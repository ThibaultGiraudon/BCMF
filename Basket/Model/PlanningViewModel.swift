//
//  PlanningViewModel.swift
//  Basket
//
//  Created by Thibault Giraudon on 25/08/2023.
//

import Foundation
import Combine
import FirebaseFirestore

class PlanningViewModel: ObservableObject {
  
    @Published var planning: Planning
    @Published var modified = false
  
    private var cancellables = Set<AnyCancellable>()
  
    init(planning: Planning = Planning(date: "", hour: "", team1: "", team2: "", result: "", sort: 0)) {
        self.planning = planning
    
        self.$planning
            .dropFirst()
            .sink { [weak self] planning in
                self?.modified = true
            }
      .store(in: &self.cancellables)
    }
  
    private var db = Firestore.firestore()
  
    private func addPlanning(_ planning: Planning) {
        do {
            let _ = try db.collection("dates").addDocument(from: planning)
        }
        catch {
            print(error)
        }
    }
    
    private func updatePlanning(_ planning: Planning) {
        if let documentId = planning.id {
            do {
                try db.collection("dates").document(documentId).setData(from: planning)
            }
            catch {
                print(error)
            }
        }
    }
    
    private func removePlanning() {
        if let documentId = planning.id {
            db.collection("dates").document(documentId).delete { error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func updateOrAddPlanning() {
        if let _ = planning.id {
            self.updatePlanning(self.planning)
        }
        else {
            addPlanning(planning)
        }
    }
  
    func handleDoneTapped() {
        self.updateOrAddPlanning()
    }
    
    func handleDeleteTapped() {
        self.removePlanning()
    }
}
