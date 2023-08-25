//
//  clubViewModel.swift
//  Basket
//
//  Created by Thibault Giraudon on 06/03/2023.
//

import Foundation
import FirebaseFirestore

class ViewModel: ObservableObject {
    @Published var clubs = [Club]()
    @Published var plannings = [Planning]()
    @Published var players = [Player]()

    private var db = Firestore.firestore()

    func fetchData() {
        db.collection("clubs").order(by: "rank").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
          
            self.clubs = documents.compactMap { queryDocumentSnapshot -> Club? in
                return try? queryDocumentSnapshot.data(as: Club.self)
            }
      }

        db.collection("dates").order(by: "sort").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }

            self.plannings = documents.compactMap { queryDocumentSnapshot -> Planning? in
                return try? queryDocumentSnapshot.data(as: Planning.self)
            }
        }
        
        db.collection("players").order(by: "number").addSnapshotListener { (querySnapshot, error) in
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
