//
//  FirebasePhotoGallery.swift
//  Basket
//
//  Created by Thibault Giraudon on 24/12/2023.
//

import SwiftUI
import Firebase
import FirebaseStorage
import SDWebImageSwiftUI

struct FirebasePhotoPicker: View {
    @Environment(\.dismiss) private var dismiss
    @State private var imageURLs: [URL] = []
    @Binding var selectedImage: String

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                ForEach(imageURLs, id: \.self) { imageURL in
                    Button {
                        selectedImage = imageURL.absoluteString
                        dismiss()
                    } label: {
                        WebImage(url: imageURL)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipped()
                            .cornerRadius(8)
                    }
                }
            }
        }
        .padding()
        .onAppear {
            fetchImagesFromFirebaseStorage()
        }
    }

    func fetchImagesFromFirebaseStorage() {
        let storage = Storage.storage()

        // Remplacez "your-path" par le chemin réel dans votre stockage Firebase où vous avez stocké vos images.
        let storageRef = storage.reference().child("logo-teams")
        storageRef.listAll { (result, error) in
            if let error = error {
                    print("Error while listing all files: ", error)
            }

            if let items = result?.items {

                for item in items {
                    print("Item in images folder: ", item)
                    item.downloadURL { url, error in

                        if let url = url {
                            self.imageURLs.append(url)
                        } else if let error = error {
                            print("Error getting download URL: \(error.localizedDescription)")
                        }
                    }
                }
            }
        }
    }
}

