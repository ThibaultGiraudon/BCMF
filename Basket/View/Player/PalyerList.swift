//
//  PlayerList.swift
//  Basket
//
//  Created by Thibault Giraudon on 27/02/2023. 
//

import SwiftUI

struct PlayerList: View {
    @ObservedObject private var viewModel = PlayersViewModel()
    @ObservedObject var gs = GlobalState.shared
    @State var presentAddPlayerSheet = false
    @State var presentLoginSheet = false
    
    var body: some View {
        VStack {
            Divider()
            ForEach(viewModel.players) { player in
                NavigationLink(destination: PlayerDetailView(player: player)) {
                    PlayerRowView(player: player)
                }
                Divider()
            }
        }
        .navigationTitle("Equipe")
//        .toolbar {
//            ToolbarItem(placement: .confirmationAction) {
//                Menu {
//                    Button(action: { self.presentAddPlayerSheet.toggle() }) {
//                        Label("Add", systemImage: "plus")
//                    }
//                    Button(action: { self.presentLoginSheet.toggle() }) {
//                        Label("Profil", systemImage: "person.circle")
//                    }
//                    HStack {
//                        Toggle("Mode sombre", isOn: $gs.isDarkMode)
//                    }
//                }
//                label: {
//                    Label("Settings", systemImage: "gearshape.fill")
//                        .foregroundColor(.green)
//                }
//            }
//        }
        .sheet(isPresented: $gs.presentAddSheet) {
            PlayerEditView(mode: .new)
        }
//        .sheet(isPresented: self.$presentLoginSheet) {
//            LoginView()
//        }
        .onAppear() {
            print("PlayersListView appears. Subscribing to data updates.")
            self.viewModel.subscribe()
        }
        .preferredColorScheme(gs.isDarkMode == true ? .dark : .light)
    }
}

struct LoginButton: View {
    var action: () -> Void
    var body: some View {
        Button(action: {self.action() }) {
            Image(systemName: "person.circle")
        }
        .foregroundColor(.green)
    }
}

struct AddButton: View {
    @ObservedObject var gs = GlobalState.shared
    
    var action: () -> Void
    var body: some View {
        if gs.isAuthenticated == true {
            Button(action: { self.action() }) {
                Image(systemName: "plus")
            }
            .foregroundColor(.green)
        }
    }
}

struct PlayerList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PlayerList()
        }
    }
}
