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

let placeholder = UIImage(systemName: "person.fill")!

struct PlayerImage: View {
    var image: String
    @State private var path: String = "player_images/"
    @State private var imageURL: URL?
    
    var body: some View {
            WebImage(url: imageURL)
                .resizable()
                .frame(width: 271, height: 384)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .overlay {
                    Circle().stroke(.white, lineWidth: 4)
                }
                .shadow(radius: 7)
                .onAppear {
                    let storage = Storage.storage()

                    let storageRef = storage.reference().child(path + image)
                    storageRef.downloadURL { (url, error) in
                        if let url = url {
                            self.imageURL = url
                        } else {
                            print("Erreur lors du téléchargement de l'URL de l'image: \(error?.localizedDescription ?? "Erreur inconnue")")
                        }
                    }
                }
    }
}

struct PlayerImage_Previews: PreviewProvider {
    static var previews: some View {
        PlayerImage(image: "Emma_Gailhot.jpg")
    }
}
