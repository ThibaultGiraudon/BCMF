//
//  CircleImage.swift
//  Basket
//
//  Created by Thibault Giraudon on 27/02/2023.
//

import SwiftUI

struct CircleImage: View {
    var image: Image
    var body: some View {
        image
            .resizable()
            .frame(width: 271, height: 384)
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            .overlay {
                Circle().stroke(.white, lineWidth: 4)
            }
            .shadow(radius: 7)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image: Image("Emma_Gailhot"))
    }
}
