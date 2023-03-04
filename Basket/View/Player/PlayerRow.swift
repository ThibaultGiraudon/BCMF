//
//  PlayerRow.swift
//  Basket
//
//  Created by Thibault Giraudon on 27/02/2023.
//

import SwiftUI

struct PlayerRow: View {
    var basket: Basket
    
    var body: some View {
        HStack {
            basket.image
                .resizable()
                .frame(width: 35, height: 50)
            Text(basket.name)
            
            Spacer()
        }
    }
}

struct PlayerRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PlayerRow(basket: basket[6])
            PlayerRow(basket: basket[7])
        }
            .previewLayout(.fixed(width: 300, height: 70))
    }
}
