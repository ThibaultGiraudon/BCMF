//
//  PlanningsViewModel.swift
//  Basket
//
//  Created by Thibault Giraudon on 26/08/2023.
//

import Foundation
import FirebaseFirestore

class PlanningsViewModel: ObservableObject {
    @Published var plannings = [Planning]()
    
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
            listenerRegistration = db.collection("dates").order(by: "sort").addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                
                self.plannings = documents.compactMap { queryDocumentSnapshot -> Planning? in
                    return try? queryDocumentSnapshot.data(as: Planning.self)
                }
            }
        }
    }
}

