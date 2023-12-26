//
//  EventViewModel.swift
//  Basket
//
//  Created by Thibault Giraudon on 23/12/2023.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseStorage

class EventViewModel: ObservableObject {
    let db = Firestore.firestore()
    let formType: FormType
    
    let id: String
    @Published var type = "match"
    @Published var title = ""
    @Published var team1_name = ""
    @Published var team2_name = ""
    @Published var team1_image = ""
    @Published var team2_image = ""
    @Published var description = ""
    @Published var date = Date.now
    @Published var hour = Date.now
    @Published var imageURL: URL?
    
    @Published var uploadProgress: uploadProgress?
    @Published var error: String?
    
    init(formType: FormType = .add) {
        self.formType = formType
        switch formType {
        case .add:
            id = UUID().uuidString
        case .edit(let item):
            id = item.id
            type = item.type
            title = item.title
            team1_name = item.team1_name
            team2_name = item.team2_name
            team1_image = item.team1_image
            team2_image = item.team2_image
            description = item.description
            date = item.date
            hour = item.hour
            if let imageURL = item.imageURL {
                self.imageURL = imageURL
            }
        }
    }
    
    func clear() {
        type = "match"
        title = ""
        team1_name = ""
        team2_name = ""
        team1_image = ""
        team2_image = ""
        description = ""
        date = Date.now
        hour = Date.now
        imageURL = URL(string: "")
    }
    
    func save() throws {
        var item: Event
        switch formType {
        case .add:
            item = .init(title: title, description: description, team1_name: team1_name, team2_name: team2_name, team1_image: team1_image, team2_image: team2_image, date: date, hour: hour, type: type)
        case .edit(let event):
            item = event
            item.type = type
            item.title = title
            item.team1_name = team1_name
            item.team2_name = team2_name
            item.team1_image = team1_image
            item.team2_image = team2_image
            item.description = description
            item.date = date
            item.hour = hour
        }
        item.image = imageURL?.absoluteString
        print("image link \(item.image ?? "fail")")
        
        do {
            try db.document("events/\(item.id)")
                .setData(from: item)
        } catch {
            self.error = error.localizedDescription
            throw error
        }
    }
    
    @MainActor
    func uploadImage(_ image: UIImage) async {
        do {
            
            let storage = Storage.storage()
            let storageRef = storage.reference()
            let imageRef = storageRef.child("events/\(UUID().uuidString).jpg")
            print("enter in uploadImage")
            
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            
            uploadProgress = .init(fractionCompleted: 0, totalUnitCount: 0, completedUnitCount: 0)
            
            guard let data = image.pngData() else { return }
            
            _ = try await imageRef.putDataAsync(data, metadata: metadata) { [weak self] progress in
                           guard let self, let progress else { return }
                           self.uploadProgress = .init(fractionCompleted: progress.fractionCompleted, totalUnitCount: progress.totalUnitCount, completedUnitCount: progress.completedUnitCount)
                       }
            let downloadURL = try await imageRef.downloadURL()
            
            self.imageURL = downloadURL
            print("Successfully download url \(self.imageURL?.absoluteString ?? "Fail")")
        } catch {
            self.error = error.localizedDescription
        }
    }
    
    @MainActor
    func deleteItem(_ id: String) async throws {
        do {
            try await db.document("events/\(id)").delete()
        } catch {
            throw error
        }
    }
}

enum FormType: Identifiable {
    case add
    case edit(Event)
    
    var id: String {
        switch self {
        case .add:
            return "add"
        case .edit(let event):
            return "edit-\(event.id)"
        }
    }
}

struct uploadProgress {
    var fractionCompleted: Double
    var totalUnitCount: Int64
    var completedUnitCount: Int64
}

