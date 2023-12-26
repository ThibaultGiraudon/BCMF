//
//  Date.swift
//  Basket
//
//  Created by Thibault Giraudon on 28/02/2023.
//

import Foundation
import FirebaseFirestoreSwift
import SwiftUI

struct Planning: Hashable, Codable, Identifiable {
    @DocumentID var id: String?
    var date: Date
    var hour: Date
    var team1: String
    var team2: String
    var result: String
    var image1: String
    var image2: String
    var description: String
    var sort: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case date
        case hour
        case team1
        case team2
        case result
        case image1
        case image2
        case description
        case sort
    }
}
