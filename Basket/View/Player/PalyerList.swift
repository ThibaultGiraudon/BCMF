//
//  PlayerList.swift
//  Basket
//
//  Created by Thibault Giraudon on 27/02/2023. 
//

import SwiftUI

struct PlayerList: View {
    @ObservedObject private var viewModel = PlayersViewModel()
    @State private var searchText = ""

    var body: some View {

        List {
            Section {
                TextField("Rechercher un joueur", text: $searchText)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            Section {
                ForEach(filteredPlayers) { player in
                    NavigationLink(destination: PlayerDetailView(player: player)) {
                        PlayerRowView(player: player)
                    }
                }
            }
        }
        .listStyle(.inset)
        .onAppear() {
            print("PlayersListView appears. Subscribing to data updates.")
            self.viewModel.subscribe()
        }
    }

    private var filteredPlayers: [Player] {
        if searchText.isEmpty {
            return viewModel.players
        } else {
            return viewModel.players.filter { player in
                player.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}


struct AddButton: View {
    
    var action: () -> Void
    var body: some View {
        Button(action: { self.action() }) {
            Image(systemName: "plus")
        }
        .foregroundColor(.green)
    }
}

struct PlayerList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PlayerList()
        }
    }
}
