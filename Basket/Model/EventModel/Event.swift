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
    var info: String
    var team1_name: String
    var team2_name: String
    var team1_image: String
    var team2_image: String
    var score: String
    var date: Date
    var hour: Date
    var type: String
    var image_id: String?
    var image: String?
    var imageURL: URL? {
        guard let image else { return nil }
        return URL(string: image)
    }
}
