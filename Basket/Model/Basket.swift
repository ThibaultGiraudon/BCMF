//
//  Basket.swift
//  Basket
//
//  Created by Thibault Giraudon on 27/02/2023.
//

import Foundation
import SwiftUI

struct Basket: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var post: String
    var weight: String
    var description: String
    
    private var imageName: String
    var image: Image {
        Image(imageName)
    }
}
