//
//  PlayerViewModel.swift
//  Basket
//
//  Created by Thibault Giraudon on 25/08/2023.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseStorage

class PlayersViewModel: ObservableObject {
    @Published var players = [Player]()
    
    @MainActor
    func listenToItems() {
        Firestore.firestore().collection("players").order(by: "number")
            .addSnapshotListener { snapshot, error in
                guard let snapshot else {
                    print("Error fetching snapshot: \(error?.localizedDescription ?? "error")")
                    return
                }
                let docs = snapshot.documents
                let items = docs.compactMap {
                    try? $0.data(as: Player.self)
                }
                
                withAnimation {
                    self.players = items
                }
            }
    }
}
