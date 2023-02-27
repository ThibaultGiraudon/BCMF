//
//  BasketList.swift
//  Basket
//
//  Created by Thibault Giraudon on 27/02/2023.
//

import SwiftUI

struct BasketPlayerList: View {
    var body: some View {
        NavigationView {
            List (basket) { basket in
                NavigationLink {
                    BasketDetail(basket: basket)
                } label: {
                    BasketRow(basket: basket)
                }
            }
            .navigationTitle("BCMF")
        }
    }
}

struct BasketPlayerList_Previews: PreviewProvider {
    static var previews: some View {
        BasketPlayerList()
    }
}
