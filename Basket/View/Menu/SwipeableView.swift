//
//  SwipeableView.swift
//  Basket
//
//  Created by Thibault Giraudon on 11/09/2023.
//

import SwiftUI

struct SwipeableView: View {
    private let views: [any View] = [PlayerList(), PlanningView(), RankingView()]
    @ObservedObject var gs = GlobalState.shared
    @State var presentLoginSheet = false
    
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
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Menu {
                    if (gs.isAuthenticated == true) {
                        Button(action: { gs.presentAddSheet.toggle() }) {
                            Label("Add", systemImage: "plus")
                        }
                    }
                    Button(action: { self.presentLoginSheet.toggle() }) {
                        Label("Profil", systemImage: "person.circle")
                    }
                    Toggle("Mode sombre", isOn: $gs.isDarkMode)
                }
                label: {
                    Label("Settings", systemImage: "gearshape.fill")
                        .foregroundColor(.green)
                }
            }
        }
        .sheet(isPresented: self.$presentLoginSheet) {
            LoginView()
        }
    }
}

struct SwipeableView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SwipeableView()
        }
    }
}
