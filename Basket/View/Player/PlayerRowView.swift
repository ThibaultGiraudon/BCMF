//
//  PlayerRowView.swift
//  Basket
//
//  Created by Thibault Giraudon on 26/08/2023.
//

import SwiftUI

struct  PlayerRowView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var player: Player
    var body: some View {
        HStack {
            Image(player.imageURL)
                .resizable()
                .scaledToFill()
                .frame(width: 35, height: 45, alignment: .bottom)
                .mask(Rectangle().edgesIgnoringSafeArea(.top))
            Text(player.name)
            
            Spacer()
        }
        .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
        .padding(.horizontal)
    }
}

struct PlayerRowView_Previews: PreviewProvider {
    static var previews: some View {
        let player = Player(name: "Emma Gailhot", number: 12, size: "1.77", total: "0", imageURL: "Emma_Gailhot", post: "4", description: ("null"))
        PlayerRowView(player: player)
    }
}
