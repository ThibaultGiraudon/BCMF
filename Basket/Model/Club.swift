//
//  Club.swift
//  Basket
//
//  Created by Thibault Giraudon on 27/02/2023.
//

import Foundation
import FirebaseFirestoreSwift
import SwiftUI

struct Club: Hashable, Codable, Identifiable {
    @DocumentID var id: String?
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
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case pts
        case play
        case win
        case loose
        case null
        case scored
        case taken
        case diff
        case rank
    }
}
