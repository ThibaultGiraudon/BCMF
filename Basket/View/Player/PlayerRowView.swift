//
//  PlayerRowView.swift
//  Basket
//
//  Created by Thibault Giraudon on 26/08/2023.
//

import SwiftUI
import Combine
import FirebaseStorage
import SDWebImageSwiftUI

struct  PlayerRowView: View {
    var player: Player
    var body: some View {
        HStack {
            WebImage(url: URL(string: player.image))
                .resizable()
                .scaledToFill()
                .frame(width: 70, height: 90, alignment: .bottom)
                .clipShape(Circle())
                .overlay(content: {
                    Circle()
                        .stroke()
                        .foregroundStyle(.green)
                })
            Text(player.name)
                .foregroundStyle(.black)
            Spacer()
        }
        .padding(.horizontal, 20)
    }
}

struct PlayerRowView_Previews: PreviewProvider {
    static var previews: some View {
        let player = Player(name: "Emma Gailhot", number: 12, size: "1.77", total: "0", post: "4", description: "J'aime le basket", image_id: "", image: "https://firebasestorage.googleapis.com/v0/b/bcmf-d3d8a.appspot.com/o/player_images%2FEmma_Gailhot.jpg?alt=media&token=81b7eb90-17d2-4d27-a089-9ac9539f889f")
        PlayerRowView(player: player)
    }
}
