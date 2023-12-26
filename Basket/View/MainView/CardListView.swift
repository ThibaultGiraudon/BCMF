//
//  MainView.swift
//  Basket
//
//  Created by Thibault Giraudon on 22/12/2023.
//

import SwiftUI

struct CardListView: View {
    @ObservedObject private var viewModel = EventsViewModel()
    @State private var currentIndex: Int = 0

    private var filteredEvents: [Event] {
        return viewModel.events.filter { $0.score != "0 - 0" }
    }
    
    var body: some View {
        TabView(selection: $currentIndex) {
            ForEach(filteredEvents.indices, id: \.self) { index in
                NavigationLink {
//                    PlanningEditView(viewModel: PlanningViewModel(planning: filteredEvents[index]), mode: .edit)
                } label: {
                    MatchCardView(event: filteredEvents[index])
                        .foregroundStyle(.black)
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .overlay(alignment: .bottom) {
            SliderIndicatorView(pageIndex: currentIndex, pageCount: filteredEvents.count)
        }
        .onAppear() {
            self.viewModel.listenToItems()
        }
        .cornerRadius(25.0)
    }
}

#Preview {
    NavigationStack {
        CardListView()
            .frame(maxWidth: .infinity, maxHeight: 270)
            .padding(.horizontal)
    }
}

