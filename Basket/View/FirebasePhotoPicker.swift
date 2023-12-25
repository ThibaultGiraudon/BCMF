//
//  FirebasePhotoPicker.swift
//  Basket
//
//  Created by Thibault Giraudon on 24/12/2023.
//

import SwiftUI
import Firebase
import FirebaseStorage

struct FirebasePhotoPicker: View {
    @State private var selectedImage: UIImage?

    var body: some View {
        VStack {
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            } else {
                Button("Select Photo") {
                    // Utilisez votre propre logique pour présenter le sélecteur de photos ici
                    // Par exemple, utilisez UIImagePickerController ou une bibliothèque tierce
                    // N'oubliez pas de récupérer l'URL de l'image sélectionnée depuis Firebase Storage
                    // et de charger l'image dans selectedImage
                }
            }
        }
    }
}

struct FirebasePhotoPicker_Previews: PreviewProvider {
    static var previews: some View {
        FirebasePhotoPicker()
    }
}
