//
//  ClubsViewModel.swift
//  Basket
//
//  Created by Thibault Giraudon on 26/08/2023.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseStorage

class ClubsViewModel: ObservableObject {
    @Published var clubs = [Club]()
    
    @MainActor
    func listenToItems() {
        Firestore.firestore().collection("clubs").order(by: "rank")
            .addSnapshotListener { snapshot, error in
                guard let snapshot else {
                    print("Error fetching snapshot: \(error?.localizedDescription ?? "error")")
                    return
                }
                let docs = snapshot.documents
                let items = docs.compactMap {
                    try? $0.data(as: Club.self)
                }
                
                withAnimation {
                    self.clubs = items
                }
            }
    }
}
