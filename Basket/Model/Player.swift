//
//  Player.swift
//  Basket
//
//  Created by Thibault Giraudon on 27/02/2023.
//

import Foundation
import FirebaseFirestoreSwift
import SwiftUI

struct Player: Hashable, Codable, Identifiable {
    @DocumentID var id: String?
    var name: String
    var size: String
    var total: String
    var imageURL: String
    var post: String
    var description: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case size
        case total
        case imageURL
        case post
        case description
    }
}
