//
//  MainView.swift
//  Basket
//
//  Created by Thibault Giraudon on 22/12/2023.
//

import SwiftUI

struct CardListView: View {
    @ObservedObject private var viewModel = PlanningsViewModel()
    @State private var currentIndex: Int = 0
    
    // Filtered plannings with a result different from "-"
    private var filteredPlannings: [Planning] {
        return viewModel.plannings.filter { $0.result != "-" }
    }
    
    var body: some View {
        TabView(selection: $currentIndex) {
            ForEach(filteredPlannings.indices, id: \.self) { index in
                CardView(planning: filteredPlannings[index])
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .overlay(alignment: .bottom) {
            SliderIndicatorView(pageIndex: currentIndex, pageCount: filteredPlannings.count)
        }
        .onAppear() {
            self.viewModel.subscribe()
        }
        .cornerRadius(25.0)
    }
}

#Preview {
    CardListView()
        .frame(maxWidth: .infinity, maxHeight: 210)
        .padding(.horizontal)
}

