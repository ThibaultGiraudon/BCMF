//
//  PlayerViewModel.swift
//  Basket
//
//  Created by Thibault Giraudon on 25/08/2023.
//

import Foundation
import FirebaseFirestore

class PlayersViewModel: ObservableObject {
    @Published var players = [Player]()

    private var db = Firestore.firestore()
    private var listenerRegistration: ListenerRegistration?
    
    deinit {
        unsubscribe()
    }
    
    func unsubscribe() {
        if listenerRegistration != nil {
            listenerRegistration?.remove()
            listenerRegistration = nil
        }
    }
    
    func subscribe() {
        if listenerRegistration == nil {
            listenerRegistration = db.collection("players").order(by: "number").addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                self.players = documents.compactMap { queryDocumentSnapshot -> Player? in
                    return try? queryDocumentSnapshot.data(as: Player.self)
                }
            }
        }
    }
}
