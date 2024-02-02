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

class PlayerViewModel: ObservableObject {
    let db = Firestore.firestore()
    let formType: PlayerFormType
    
    let id: String
    @Published var name = ""
    @Published var number: Int?
    @Published var size = ""
    @Published var total = ""
    @Published var post = ""
    @Published var description = ""
    @Published var image_id = ""
    @Published var image = ""
    @Published var imageURL: String?
    
    @Published var uploadProgress: uploadProgress?
    @Published var error: String?
    
    init(formType: PlayerFormType = .add) {
        self.formType = formType
        switch formType {
        case .add:
            id = UUID().uuidString
        case .edit(let item):
            id = item.id
            name = item.name
            number = item.number
            size = item.size
            total = item.total
            post = item.post
            description = item.description
            image_id = item.image_id
            image = item.image
            if let imageURL = item.imageURL {
                self.imageURL = imageURL
            }
        }
    }
    
    func clear() {
        name = ""
        size = ""
        total = ""
        post = ""
        description = ""
        image_id = ""
        image = ""
    }
    
    func save() async throws {
        var item: Player
        switch formType {
        case .add:
            item = .init(name: name, number: number ?? 0, size: size, total: total, post: post, description: description, image_id: image_id, image: image)
        case .edit(let player):
            item = player
            item.name = name
            item.size = size
            item.total = total
            item.description = description
            item.post = post
            item.image_id = image_id
            item.image = image
        }
        
        do {
            try db.document("players/\(item.id)")
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
            let imageRef = storageRef.child("players/\(new_id).jpg")
            self.image_id = new_id
            
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            
            uploadProgress = .init(fractionCompleted: 0, totalUnitCount: 0, completedUnitCount: 0)
            
            guard let data = image.pngData() else { return }
            
            _ = try await imageRef.putDataAsync(data, metadata: metadata) { [weak self] progress in
                           guard let self, let progress else { return }
                           self.uploadProgress = .init(fractionCompleted: progress.fractionCompleted, totalUnitCount: progress.totalUnitCount, completedUnitCount: progress.completedUnitCount)
                       }
            let downloadURL = try await imageRef.downloadURL()
            
            self.imageURL = downloadURL.absoluteString
            self.image = downloadURL.absoluteString
        } catch {
            self.error = error.localizedDescription
        }
    }
    
    @MainActor
    func deleteImages() async throws {
        do {
            try await Storage.storage().reference().child("players/\(image_id).jpg").delete()
            image_id = ""
            image = ""
        } catch {
            print("Erreur lors de la suppression de l'image \(image_id): \(error)")
        }
    }
    
    @MainActor
    func deleteItem() async throws {
        do {
            try await db.document("players/\(id)").delete()
            try await deleteImages()
        } catch {
            throw error
        }
    }
}

enum PlayerFormType: Identifiable {
    case add
    case edit(Player)
    
    var id: String {
        switch self {
        case .add:
            return "add"
        case .edit(let player):
            return "edit-\(player.id)"
        }
    }
}
