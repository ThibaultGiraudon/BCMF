//
//  PlayerDetailView.swift
//  Basket
//
//  Created by Thibault Giraudon on 26/08/2023.
//

import SwiftUI

struct PlayerDetailView: View {
    @Environment(\.dismiss) var dismiss
    @State var formType: PlayerFormType?
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
                        PlayerImage(image: player.image)
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
            Button {
                formType = .edit(player)
            } label: {
                Text("Edit")
            }
        )
        .sheet(item: $formType) { type in
            NavigationStack {
                PlayerEditView(viewModel: .init(formType: type))
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
        NavigationStack {
            let player = Player(name: "Emma Gailhot", number: 12, size: "1.77", total: "0", post: "4", description: "J'aime le basket", image_id: "", image: "https://firebasestorage.googleapis.com/v0/b/bcmf-d3d8a.appspot.com/o/player_images%2FEmma_Gailhot.jpg?alt=media&token=81b7eb90-17d2-4d27-a089-9ac9539f889f")
            PlayerDetailView(player: player)
        }
    }
}
