//
//  Player.swift
//  Basket
//
//  Created by Thibault Giraudon on 27/02/2023.
//

import Foundation
import SwiftUI

struct Player: Hashable, Codable, Identifiable {
    var id: String = UUID().uuidString
    var name: String
    var size: String
    var total: String
    var imageURL: String
    var post: String
    var description: String
}
