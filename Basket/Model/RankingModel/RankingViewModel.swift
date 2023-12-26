//
//  clubViewModel.swift
//  Basket
//
//  Created by Thibault Giraudon on 06/03/2023.
//

import Foundation
import Combine
import FirebaseFirestore

class RankingViewModel: ObservableObject {
  
    @Published var club: Club
    @Published var modified = false
  
    private var cancellables = Set<AnyCancellable>()
  
    init(club: Club = Club(name: "", image: "", pts: "", play: "", win: "", loose: "", null: "", scored: "", taken: "", diff: "", rank: "")) {
        self.club = club
    
        self.$club
            .dropFirst()
            .sink { [weak self] club in
                self?.modified = true
            }
      .store(in: &self.cancellables)
    }
  
    private var db = Firestore.firestore()
  
    private func addClub(_ club: Club) {
        do {
            let _ = try db.collection("clubs").addDocument(from: club)
        }
        catch {
            print(error)
        }
    }
    
    private func updateClub(_ club: Club) {
        if let documentId = club.id {
            do {
                try db.collection("clubs").document(documentId).setData(from: club)
            }
            catch {
                print(error)
            }
        }
    }
    
    private func removeClub() {
        if let documentId = club.id {
            db.collection("clubs").document(documentId).delete { error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func updateOrAddClub() {
        if let _ = club.id {
            self.updateClub(self.club)
        }
        else {
            addClub(club)
        }
    }
  
    func handleDoneTapped() {
        self.updateOrAddClub()
    }
    
    func handleDeleteTapped() {
        self.removeClub()
    }
}

