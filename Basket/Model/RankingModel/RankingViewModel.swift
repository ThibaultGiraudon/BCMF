//
//  clubViewModel.swift
//  Basket
//
//  Created by Thibault Giraudon on 06/03/2023.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseStorage

class ClubViewModel: ObservableObject {
    let db = Firestore.firestore()
    let formType: ClubFormType
    
    let id: String
    @Published var name = ""
    @Published var pts = ""
    @Published var play = ""
    @Published var win = ""
    @Published var loose = ""
    @Published var null = ""
    @Published var scored = ""
    @Published var taken = ""
    @Published var diff = ""
    @Published var rank = ""
    @Published var image_id: String?
    @Published var imageURL: URL?
    
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
    
    init(formType: ClubFormType = .add) {
        self.formType = formType
        switch formType {
        case .add:
            id = UUID().uuidString
        case .edit(let item):
            id = item.id
            name = item.name
            pts = item.pts
            play = item.play
            win = item.win
            loose = item.loose
            null = item.null
            scored = item.scored
            taken = item.taken
            diff = item.diff
            rank = item.rank
            if let imageURL = item.imageURL {
                self.imageURL = imageURL
            }
        }
    }
    
    func clear() {
        name = ""
        pts = ""
        play = ""
        win = ""
        loose = ""
        null = ""
        scored = ""
        taken = ""
        diff = ""
        rank = ""
        imageURL = URL(string: "")
    }
    
    func save() async throws {
        var item: Club
        switch formType {
        case .add:
            item = .init(name: name, pts: pts, play: play, win: win, loose: loose, null: null, scored: scored, taken: taken, diff: diff, rank: rank)
        case .edit(let club):
            item = club
            item.name = name
            item.pts = pts
            item.play = play
            item.win = win
            item.loose = loose
            item.null = null
            item.scored = scored
            item.taken = taken
            item.diff = diff
            item.rank = rank
        }
        item.image = imageURL?.absoluteString
        item.image_id = image_id
        
        do {
            try db.document("clubs/\(item.id)")
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
            let imageRef = storageRef.child("clubs/\(new_id).jpg")
            image_id = new_id
            
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
    func deleteItem() async throws {
        do {
            try await db.document("clubs/\(id)").delete()
            if let image_id = image_id {
                try? await Storage.storage().reference().child("clubs/\(image_id).jpg").delete()
            }
        } catch {
            throw error
        }
    }
}

enum ClubFormType: Identifiable {
    case add
    case edit(Club)
    
    var id: String {
        switch self {
        case .add:
            return "add"
        case .edit(let club):
            return "edit-\(club.id)"
        }
    }
}
