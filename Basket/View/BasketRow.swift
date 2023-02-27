//
//  BasketRow.swift
//  Basket
//
//  Created by Thibault Giraudon on 27/02/2023.
//

import SwiftUI

struct BasketRow: View {
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

struct BasketRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BasketRow(basket: basket[6])
            BasketRow(basket: basket[7])
        }
            .previewLayout(.fixed(width: 300, height: 70))
    }
}
