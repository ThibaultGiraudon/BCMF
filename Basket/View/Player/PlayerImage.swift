//
//  PlayerImage.swift
//  Basket
//
//  Created by Thibault Giraudon on 27/02/2023.
//

import SwiftUI
import Combine
import FirebaseStorage
import SDWebImageSwiftUI

struct PlayerImage: View {
    var image: String
    
    var body: some View {
        WebImage(url: URL(string: image))
            .resizable()
            .frame(width: 271, height: 384)
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            .overlay {
                Circle().stroke(.white, lineWidth: 4)
            }
            .shadow(radius: 7)
    }
}

struct PlayerImage_Previews: PreviewProvider {
    static var previews: some View {
        PlayerImage(image: "https://firebasestorage.googleapis.com/v0/b/bcmf-d3d8a.appspot.com/o/player_images%2FEmma_Gailhot.jpg?alt=media&token=81b7eb90-17d2-4d27-a089-9ac9539f889f")
    }
}
