//
//  EventsViewModel.swift
//  Basket
//
//  Created by Thibault Giraudon on 23/12/2023.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseStorage

class EventsViewModel: ObservableObject {
    @Published var items = [Event] ()
    
    @MainActor
    func listenToItems() {
        Firestore.firestore().collection("events")
            .addSnapshotListener { snapshot, error in
                guard let snapshot else {
                    print("Error fetching snapshot: \(error?.localizedDescription ?? "error")")
                    return
                }
                let docs = snapshot.documents
                let items = docs.compactMap {
                    try? $0.data(as: Event.self)
                }
                
                withAnimation {
                    self.items = items
                }
            }
    }
}
