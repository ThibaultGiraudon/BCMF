//
//  ClubsViewModel.swift
//  Basket
//
//  Created by Thibault Giraudon on 26/08/2023.
//

import Foundation
import FirebaseFirestore

class RankingsViewModel: ObservableObject {
    @Published var clubs = [Club]()
    
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
            listenerRegistration = db.collection("clubs").order(by: "rank").addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                self.clubs = documents.compactMap { queryDocumentSnapshot -> Club? in
                    return try? queryDocumentSnapshot.data(as: Club.self)
                }
            }
        }
    }
}
