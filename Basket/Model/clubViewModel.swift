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

            self.clubs = documents.map { (queryDocumentSnapshot) -> Club in
                let data = queryDocumentSnapshot.data()
                let rank = data["rank"] as? String ?? ""
                let name = data["name"] as? String ?? ""
                let pts = data["pts"] as? String ?? ""
                let play = data["play"] as? String ?? ""
                let win = data["win"] as? String ?? ""
                let loose = data["loose"] as? String ?? ""
                let null = data["null"] as? String ?? ""
                let scored = data["scored"] as? String ?? ""
                let taken = data["taken"] as? String ?? ""
                let diff = data["diff"] as? String ?? ""
                return Club(name: name, pts: pts, play: play, win: win, loose: loose, null: null, scored: scored, taken: taken, diff: diff, rank: rank)
            }
        }

        db.collection("dates").order(by: "sort").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }

            self.plannings = documents.map { (queryDocumentSnapshot) -> Planning in
                let data = queryDocumentSnapshot.data()
                let date = data["date"] as? String ?? ""
                let hour = data["hour"] as? String ?? ""
                let team1 = data["team1"] as? String ?? ""
                let team2 = data["team2"] as? String ?? ""
                let result = data["result"] as? String ?? ""
                return Planning(date: date, hour: hour, team1: team1, team2: team2, result: result)
            }
        }
        
        db.collection("players").order(by: "number").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }

            self.players = documents.map { (queryDocumentSnapshot) -> Player in
                let data = queryDocumentSnapshot.data()
                let name = data["name"] as? String ?? ""
                let size = data["size"] as? String ?? ""
                let total = data["total"] as? String ?? ""
                let imageURL = data["imageURL"] as? String ?? ""
                let post = data["post"] as? String ?? ""
                let description = data["description"] as? String ?? ""
                return Player(name: name, size: size, total: total, imageURL: imageURL, post: post, description: description)
            }
        }
    }
}
