//
//  PlayerDetail.swift
//  Basket
//
//  Created by Thibault Giraudon on 27/02/2023.
//

import SwiftUI

struct PlayerDetail: View {
    var basket: Basket
    
    var body: some View {
        ScrollView{
            VStack {
                Image("bcmf")
                    .ignoresSafeArea(edges: .top)
                    .frame(height: 300)
                
                PlayerImage(image: basket.image)
                    .offset(y: -130)
                    .padding(.bottom, -130)
                
                VStack(alignment: .leading) {
                    Text(basket.name)
                        .font(.title)
                    Text(basket.total_scored)
                    HStack {
                        Text(basket.post)
                        Spacer()
                        Text(basket.weight)
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
//                    
//                    Divider()
//                    
//                    Text("About \(basket.name)")
//                        .font(.title2)
//                    Text(basket.description)
                }
                .padding()
            }
            .navigationTitle(basket.name)
            .navigationBarTitleDisplayMode(.inline)
            .ignoresSafeArea()
        }
    }
}

struct PlayerDetail_Previews: PreviewProvider {
    static var previews: some View {
        PlayerDetail(basket: basket[7])
    }
}
