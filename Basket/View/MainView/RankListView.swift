//
//  RankListView.swift
//  Basket
//
//  Created by Thibault Giraudon on 26/12/2023.
//

import SwiftUI

struct RankListView: View {
    @ObservedObject private var viewModel = ClubsViewModel()
    @State private var currentIndex: Int = 0
    @State var formType: ClubFormType?
    
    var body: some View {
        TabView(selection: $currentIndex) {
            ForEach(viewModel.clubs.indices, id: \.self) { index in
                Button {
                    formType = .edit(viewModel.clubs[index])
                } label: {
                RankCardView(club: viewModel.clubs[index])
                }
                .foregroundStyle(.black)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .overlay(alignment: .bottom) {
            SliderIndicatorView(pageIndex: currentIndex, pageCount: viewModel.clubs.count)
        }
        .sheet(item: $formType) { type in
            NavigationStack {
                ClubEditView(viewModel: .init(formType: type))
            }
        }
        .onAppear {
            self.viewModel.listenToItems()
        }
    }
}

#Preview {
    NavigationStack {
        RankListView()
            .frame(maxWidth: .infinity, maxHeight: 320)
    }
}
