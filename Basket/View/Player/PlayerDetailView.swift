//
//  PlayerDetailView.swift
//  Basket
//
//  Created by Thibault Giraudon on 26/08/2023.
//

import SwiftUI

struct PlayerDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var presentEditPlayerSheet = false
    var player: Player
    @ObservedObject var gs = GlobalState.shared
    
    var body: some View {
        VStack {
            PlayerImage(url: player.imageURL)
            VStack(alignment: .leading) {
                Text(player.name)
                    .font(.title)
                Text(player.total)
                Divider()
                HStack {
                    Text("Post \(player.post)")
                    Spacer()
                    Text("Taille : \(player.size)")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                if !(player.description.contains("(null)")) {
                    Divider()
                    Text(player.description)
                }
            }
            .padding()
        }
        .navigationTitle(player.name)
        .navigationBarItems(trailing:
                                Button(action: {self.presentEditPlayerSheet.toggle() }) {
            if gs.isAuthenticated == true {
                Text("Edit")}
        }
                            )
        .onAppear() {
            print("PlayerDetailsView.onAppear() for \(self.player.name)")
        }
        .onDisappear() {
          print("PlayerDetailsView.onDisappear()")
        }
        .sheet(isPresented: self.$presentEditPlayerSheet) {
            PlayerEditView(viewModel: PlayerViewModel(player: player), mode: .edit) { result in
                if case .success(let action) = result, action == .delete {
                  self.presentationMode.wrappedValue.dismiss()
                }
              }
        }
        .navigationBarTitleDisplayMode(.inline)
        .ignoresSafeArea()
    }
}

struct PlayerDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let player = Player(name: "Emma Gailhot", number: 12, size: "1.77", total: "0", imageURL: "Emma_Gailhot", post: "4", description: ("null"))
        PlayerDetailView(player: player)
    }
}
