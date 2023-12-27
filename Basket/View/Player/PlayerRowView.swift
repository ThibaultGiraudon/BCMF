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
    @State private var path: String = "player_images/"
    @State private var imageURL: URL?
    var player: Player
    var body: some View {
        HStack {
            WebImage(url: imageURL)
                .resizable()
                .scaledToFill()
                .frame(width: 70, height: 90, alignment: .bottom)
                .clipShape(Circle())
                .overlay(content: {
                    Circle()
                        .stroke()
                        .foregroundStyle(.green)
                })
                .onAppear {
                    let storage = Storage.storage()
                    
                    let storageRef = storage.reference().child(path + player.imageURL)
                    storageRef.downloadURL { (url, error) in
                        if let url = url {
                            self.imageURL = url
                        }
                        else {
                            print("Erreur lors du téléchargement de l'URL de l'image: \(error?.localizedDescription ?? "Erreur inconnue")")
                        }
                    }
                }
            Text(player.name)
                .foregroundStyle(.black)
            Spacer()
        }
        .padding(.horizontal, 20)
    }
}

struct PlayerRowView_Previews: PreviewProvider {
    static var previews: some View {
        let player = Player(name: "Emma Gailhot", number: 12, size: "1.77", total: "0", imageURL: "Emma_Gailhot.jpg", post: "4", description: ("null"))
        PlayerRowView(player: player)
    }
}
