//
//  Event.swift
//  Basket
//
//  Created by Thibault Giraudon on 23/12/2023.
//
import Foundation
import FirebaseFirestoreSwift
import SwiftUI

struct Event: Equatable, Codable, Identifiable {
    var id = UUID().uuidString

    var title: String
    var description: String
    var team1_name: String
    var team2_name: String
    var team1_image: String
    var team2_image: String
    var team1_score: String
    var team2_score: String
    var rank: String
    var day: String
    var group: String
    var date: Date
    var type: String
    var images_id: [String]
    var images: [String]
    var imageURLs: [String]?
}
