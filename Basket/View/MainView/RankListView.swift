//
//  RankListView.swift
//  Basket
//
//  Created by Thibault Giraudon on 26/12/2023.
//

import SwiftUI

struct RankListView: View {
    @ObservedObject private var viewModel = RankingsViewModel()
    @State private var currentIndex: Int = 0
    
    var body: some View {
        TabView(selection: $currentIndex) {
            ForEach(viewModel.clubs, id: \.self) { club in
                    RankCardView(club: club)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .overlay(alignment: .bottom) {
            SliderIndicatorView(pageIndex: currentIndex, pageCount: viewModel.clubs.count)
        }
        .onAppear {
            self.viewModel.subscribe()
        }
    }
}

#Preview {
    RankListView()
        .frame(maxWidth: .infinity, maxHeight: 320)
}
