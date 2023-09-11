//
//  PlayerViewModels.swift
//  Basket
//
//  Created by Thibault Giraudon on 25/08/2023.
//

import Foundation
import Combine
import FirebaseFirestore

class PlayerViewModel: ObservableObject {
  
    @Published var player: Player
    @Published var modified = false
  
    private var cancellables = Set<AnyCancellable>()
  
    init(player: Player = Player(name: "", number: 0, size: "", total: "", imageURL: "", post: "", description: "")) {
        self.player = player
    
        self.$player
            .dropFirst()
            .sink { [weak self] player in
                self?.modified = true
            }
      .store(in: &self.cancellables)
    }
  
    private var db = Firestore.firestore()
  
    private func addPlayer(_ player: Player) {
        do {
            let _ = try db.collection("players").addDocument(from: player)
        }
        catch {
            print(error)
        }
    }
    
    private func updateBook(_ player: Player) {
        if let documentId = player.id {
            do {
                try db.collection("players").document(documentId).setData(from: player)
            }
            catch {
                print(error)
            }
        }
    }
    
    private func removePlayer() {
        if let documentId = player.id {
            db.collection("players").document(documentId).delete { error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func updateOrAddPlayer() {
        if let _ = player.id {
            self.updateBook(self.player)
        }
        else {
            addPlayer(player)
        }
    }
  
    func handleDoneTapped() {
        self.updateOrAddPlayer()
    }
    
    func handleDeleteTapped() {
        self.removePlayer()
    }
}
