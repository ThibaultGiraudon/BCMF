//
//  MainView.swift
//  Basket
//
//  Created by Thibault Giraudon on 23/12/2023.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = EventsViewModel()
    var body: some View {
        List {
            Section {
                RankListView()
                    .frame(height: 320)
            }
            EventListView()
        }
        .listStyle(.inset)
    }
}

#Preview {
    MainView()
}
