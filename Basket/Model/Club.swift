//
//  Club.swift
//  Basket
//
//  Created by Thibault Giraudon on 27/02/2023.
//

import Foundation
import SwiftUI

struct Club: Hashable, Codable, Identifiable {
    var id: Int
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
}
