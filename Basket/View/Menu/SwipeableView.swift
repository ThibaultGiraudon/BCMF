//
//  SwipeableView.swift
//  Basket
//
//  Created by Thibault Giraudon on 11/09/2023.
//

import SwiftUI

struct SwipeableView: View {
    private let views: [any View] = [PlayerList(), PlanningView(), RankingView()]
    
    var body: some View {
        TabView {
            PlayerList()
            PlanningView()
            RankingView()
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .interactive))
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("BCMF")
        .ignoresSafeArea()
    }
}

struct SwipeableView_Previews: PreviewProvider {
    static var previews: some View {
       SwipeableView()
    }
}
