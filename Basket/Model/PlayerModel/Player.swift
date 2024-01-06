//
//  Player.swift
//  Basket
//
//  Created by Thibault Giraudon on 27/02/2023.
//

import Foundation
import FirebaseFirestoreSwift
import SwiftUI

struct Player: Equatable, Codable, Identifiable {
    var id = UUID().uuidString
    var name: String
    var number: String
    var size: String
    var total: String
    var post: String
    var description: String
    var image_id: String
    var image: String
    var imageURL: String?
}
