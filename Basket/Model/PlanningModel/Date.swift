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
    var date: String
    var hour: String
    var team1: String
    var team2: String
    var result: String
    var sort: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case date
        case hour
        case team1
        case team2
        case result
        case sort = "sort"
    }
}
