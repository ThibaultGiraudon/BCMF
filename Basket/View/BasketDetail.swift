//
//  BasketDetail.swift
//  Basket
//
//  Created by Thibault Giraudon on 27/02/2023.
//

import SwiftUI

struct BasketDetail: View {
    var basket: Basket
    
    var body: some View {
        ScrollView{
            VStack {
                Image("bcmf")
                    .ignoresSafeArea(edges: .top)
                    .frame(height: 300)
                
                CircleImage(image: basket.image)
                    .offset(y: -130)
                    .padding(.bottom, -130)
                
                VStack(alignment: .leading) {
                    Text(basket.name)
                        .font(.title)
                    
                    HStack {
                        Text(basket.post)
                        Spacer()
                        Text(basket.weight)
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    
                    Divider()
                    
                    Text("About \(basket.name)")
                        .font(.title2)
                    Text(basket.description)
                }
                .padding()
            }
            .navigationTitle(basket.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct BasketDetail_Previews: PreviewProvider {
    static var previews: some View {
        BasketDetail(basket: basket[7])
    }
}
