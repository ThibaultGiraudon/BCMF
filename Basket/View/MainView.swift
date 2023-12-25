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
        ScrollView {
            VStack(alignment: .center) {
                CardListView()
                    .frame(height: 210)
                HStack {
                    Text("Evenement")
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .padding()
                    Spacer()
                }
                EventCardView()
            }
        }
    }
}

#Preview {
    MainView()
}
