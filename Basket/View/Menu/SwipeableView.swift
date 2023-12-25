//
//  SwipeableView.swift
//  Basket
//
//  Created by Thibault Giraudon on 11/09/2023.
//

import SwiftUI

struct SwipeableView: View {
    @ObservedObject var gs = GlobalState.shared
    @State var presentLoginSheet = false
    
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Label("", systemImage: "house.fill")
                }
            PlayerList()
                .tabItem {
                    Label("", systemImage: "figure.basketball")
                        .foregroundStyle(.green)
            }
            EventEditView()
                .tabItem {
                    Label("", systemImage: "plus")
                }
            PlanningView()
                .tabItem {
                    Label("", systemImage: "calendar")
                        .foregroundStyle(.green)
                }
            RankingView()
                .tabItem {
                    Label("", systemImage: "trophy")
                        .foregroundStyle(.green)
                }
        }
//        .tabViewStyle(.page)
//        .indexViewStyle(.page(backgroundDisplayMode: .interactive))
//        .navigationBarTitleDisplayMode(.inline)
//        .navigationTitle("BCMF")
//        .ignoresSafeArea()
//        .toolbar {
//            ToolbarItem(placement: .confirmationAction) {
//                Menu {
//                    if (gs.isAuthenticated == true) {
//                        Button(action: { gs.presentAddSheet.toggle() }) {
//                            Label("Add", systemImage: "plus")
//                                .foregroundColor(.white)
//                        }
//                    }
//                    Button(action: { self.presentLoginSheet.toggle() }) {
//                        Label("Profil", systemImage: "person.circle")
//                    }
//                    Toggle("Mode sombre", isOn: $gs.isDarkMode)
//                }
//                label: {
//                    Label("Settings", systemImage: "gearshape.fill")
//                        .foregroundColor(.white)
//                }
//            }
//        }
//        .toolbarBackground(.green, for: .navigationBar)
//        .toolbarBackground(.visible, for: .navigationBar)
        .sheet(isPresented: self.$presentLoginSheet) {
            LoginView()
        }
    }
}


#Preview {
    NavigationView {
        SwipeableView()
    }
}
