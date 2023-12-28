//
//  Club.swift
//  Basket
//
//  Created by Thibault Giraudon on 27/02/2023.
//

import Foundation
import FirebaseFirestoreSwift
import SwiftUI

struct Club: Equatable, Codable, Identifiable {
    var id = UUID().uuidString
    
    var name: String
    var pts: String
    var play: String
    var win: String
    var loose: String
    var null: String
    var scored: String
    var taken: String
    var diff: String
    var rank: String
    var image: String?
    var image_id: String?
    var imageURL: URL? {
        guard let image else { return nil }
        return URL(string: image)
    }
}
