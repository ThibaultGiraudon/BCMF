//
//  PhotoSelectorViewModel.swift
//  Basket
//
//  Created by Thibault Giraudon on 06/01/2024.
//

import Foundation
import PhotosUI
import SwiftUI

class PhotoSelectorViewModel: ObservableObject {
    @Published var images = [UIImage]()
    @Published var selectedPhotos = [PhotosPickerItem]()
    @Published var isSelected = false
    
    @MainActor
    func convertDataToImage() {
        isSelected = false
        images = []
        if !selectedPhotos.isEmpty {
            for eachItem in selectedPhotos {
                Task {
                    if let imageData = try? await eachItem.loadTransferable(type: Data.self) {
                        if let image = UIImage(data: imageData) {
                            images.append(image)
                            isSelected = true
                        }
                    }
                }
            }
        }
        
        selectedPhotos.removeAll()
    }
}
