//
//  SwipeableView.swift
//  Basket
//
//  Created by Thibault Giraudon on 02/03/2023.
//

import SwiftUI

struct SwipeableView: View {
    @State private var selectedTab: Int = 0

    let tabs: [Tab] = [
        .init(title: "Equipe"),
        .init(title: "Classement"),
        .init(title: "Calendrier")
    ]

    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(.white)
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().isTranslucent = false
    }

    var body: some View {
        NavigationView {
            GeometryReader { geo in
                VStack(spacing: 0) {
                    Tabs(tabs: tabs, geoWidth: geo.size.width, selectedTab: $selectedTab)
                    TabView(selection: $selectedTab,
                            content: {

                                PlayerList()
                                    .tag(0)
                                RankingView()
                                    .tag(1)
                                PlanningView()
                                    .tag(2)
                            })
                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("BCMF")
                .ignoresSafeArea()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
struct SwipeableView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeableView()
    }
}
