//
//  Date.swift
//  Basket
//
//  Created by Thibault Giraudon on 28/02/2023.
//

import Foundation
import SwiftUI

struct Date: Hashable, Codable, Identifiable {
    var id: Int
    var team1: String
    var team2: String
    var date: String
    var hour: String
    var result: String
}
