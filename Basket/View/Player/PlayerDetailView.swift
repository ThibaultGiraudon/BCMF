//
//  PlayerDetailView.swift
//  Basket
//
//  Created by Thibault Giraudon on 26/08/2023.
//

import SwiftUI

struct PlayerDetailView: View {
    @Environment(\.dismiss) var dismiss
    @State var presentEditPlayerSheet = false
    var player: Player
    
    var body: some View {
        VStack {
            VStack {
                ZStack(alignment: .top) {
                    ZStack {
                        Rectangle()
                            .fill(Color.green)
                            .frame(height: UIScreen.main.bounds.height / 3)
                        Ellipse()
                            .fill(.green)
                            .frame(width: UIScreen.main.bounds.width + 50, height: 400)
                            .offset(CGSize(width: 10, height: UIScreen.main.bounds.height / 4))
                        PlayerImage(image: player.imageURL)
                            .offset(CGSize(width: 0.0, height: UIScreen.main.bounds.height / 4 + 50))
                    }
                }
                .offset(CGSize(width: 0.0, height: -400))
            }
            Group {
                Text(player.name)
                    .font(.title)
                    Text("\(player.total) points marqués sur cette saison")
                Divider()
                HStack {
                    Text("Post \(player.post)")
                    Spacer()
                    Text("Taille : \(player.size)")
                }
                .padding(.horizontal)
                .font(.subheadline)
                .foregroundColor(.secondary)
                if !(player.description.contains("(null)")) {
                    Divider()
                    Text(player.description)
                }
            }
            .offset(CGSize(width: 0, height: -170))
        }
        .navigationBarItems(trailing:
            Button(action: {self.presentEditPlayerSheet.toggle() }) {
                Text("Edit")
        }
        )
        .sheet(isPresented: self.$presentEditPlayerSheet) {
            PlayerEditView(viewModel: PlayerViewModel(player: player), mode: .edit) { result in
                if case .success(let action) = result, action == .delete {
                    self.dismiss()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: backButton)
            }
            
            var backButton: some View {
                Button {
                    dismiss()
                } label: {
                    ZStack {
                        Circle()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(.white)
                        Image(systemName: "arrow.backward")
                            .foregroundStyle(.black)
                    }
                }
            }
}

struct PlayerDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let player = Player(name: "Emma Gailhot", number: 12, size: "1.77", total: "0", imageURL: "Emma_Gailhot.jpg", post: "4", description: ("J'aime le basket"))
        PlayerDetailView(player: player)
    }
}
