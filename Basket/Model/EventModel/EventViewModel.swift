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
    @Published var info = ""
    @Published var team1_name = ""
    @Published var team2_name = ""
    @Published var team1_image = ""
    @Published var team2_image = ""
    @Published var team1_score = ""
    @Published var team2_score = ""
    @Published var rank = "LFA"
    @Published var day = "1"
    @Published var group  = "A"
    @Published var description = ""
    @Published var date = Date.now
    @Published var hour = Date.now
    @Published var images_id: [String] = []
    @Published var images: [String] = []
    @Published var imageURLs: [String]?
    
    @Published var uploadProgress: uploadProgress?
    @Published var error: String?
    
    var save_button: String {
            switch formType {
            case .add:
                return "Add Item"
            case .edit:
                return "Edit Item"
            }
        }
    
    init(formType: FormType = .add) {
        self.formType = formType
        switch formType {
        case .add:
            id = UUID().uuidString
        case .edit(let item):
            id = item.id
            title = item.title
            description = item.description
            team1_name = item.team1_name
            team2_name = item.team2_name
            team1_image = item.team1_image
            team2_image = item.team2_image
            team1_score = item.team1_score
            team2_score = item.team2_score
            rank = item.rank
            day = item.day
            group = item.group
            date = item.date
            type = item.type
            images_id = item.images_id
            images = item.images
            if let imageURLs = item.imageURLs {
                self.imageURLs = imageURLs
            }
        }
    }
    
    func clear() {
        type = "match"
        title = ""
        info = ""
        team1_name = ""
        team2_name = ""
        team1_image = ""
        team2_image = ""
        team1_score = ""
        team2_score = ""
        description = ""
        date = Date.now
        hour = Date.now
        images_id = [""]
        images = [""]
        imageURLs = [""]
    }
    
    func save() async throws {
        var item: Event
        switch formType {
        case .add:
            item = .init(title: title, description: description, team1_name: team1_name, team2_name: team2_name, team1_image: team1_image, team2_image: team2_image, team1_score: team1_score, team2_score: team2_score, rank: rank, day: day, group: group, date: date, type: type, images_id: images_id, images: images)
        case .edit(let event):
            item = event
            item.type = type
            item.title = title
            item.team1_name = team1_name
            item.team2_name = team2_name
            item.team1_image = team1_image
            item.team2_image = team2_image
            item.team1_score = team1_score
            item.team2_score = team2_score
            item.rank = rank
            item.day = day
            item.group = group
            item.description = description
            item.date = date
            item.images_id = images_id
            item.images = images
        }
        
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
            let new_id = UUID().uuidString
            let imageRef = storageRef.child("events/\(new_id).jpg")
            self.images_id.append(new_id)
            
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            
            uploadProgress = .init(fractionCompleted: 0, totalUnitCount: 0, completedUnitCount: 0)
            
            guard let data = image.pngData() else { return }
            
            _ = try await imageRef.putDataAsync(data, metadata: metadata) { [weak self] progress in
                           guard let self, let progress else { return }
                           self.uploadProgress = .init(fractionCompleted: progress.fractionCompleted, totalUnitCount: progress.totalUnitCount, completedUnitCount: progress.completedUnitCount)
                       }
            let downloadURL = try await imageRef.downloadURL()
            
            self.imageURLs?.append(downloadURL.absoluteString)
            self.images.append(downloadURL.absoluteString)
        } catch {
            self.error = error.localizedDescription
        }
    }
    
    @MainActor
    func deleteImages(_ images_id: [String]) async throws {
        for image_id in images_id {
            do {
                try await Storage.storage().reference().child("events/\(image_id).jpg").delete()
            } catch {
                print("Erreur lors de la suppression de l'image \(image_id): \(error)")
            }
        }
    }
    
    @MainActor
    func deleteItem(_ event: Event) async throws {
        do {
            try await db.document("events/\(event.id)").delete()
            try await deleteImages(event.images_id)
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

