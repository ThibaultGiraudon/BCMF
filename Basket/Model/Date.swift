//
//  Date.swift
//  Basket
//
//  Created by Thibault Giraudon on 28/02/2023.
//

import Foundation
import SwiftUI

struct Planning: Hashable, Codable, Identifiable {
    var id: String = UUID().uuidString
    var date: String
    var hour: String
    var team1: String
    var team2: String
    var result: String
}
