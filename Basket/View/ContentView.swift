//
//  ContentView.swift
//  Basket
//
//  Created by Thibault Giraudon on 27/02/2023.
//

import SwiftUI
import Firebase

struct ContentView: View {
    var body: some View {
        NavigationStack {
            SwipeableView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
