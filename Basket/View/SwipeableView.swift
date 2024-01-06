//
//  SwipeableView.swift
//  Basket
//
//  Created by Thibault Giraudon on 11/09/2023.
//

import SwiftUI

struct SwipeableView: View {
    
    var body: some View {
        ZStack {
            TabView {
                MainView()
                    .tabItem {
                        Label("", systemImage: "house.fill")
                    }
                AddView()
                    .tabItem {
                        Label("", systemImage: "plus")
                    }
                PlayerList()
                    .tabItem {
                        Label("", systemImage: "figure.basketball")
                            .foregroundStyle(.green)
                    }
            }
        }
    }
}


#Preview {
    NavigationView {
        SwipeableView()
    }
}
