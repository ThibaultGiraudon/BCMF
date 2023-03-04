//
//  PlayerList.swift
//  Basket
//
//  Created by Thibault Giraudon on 27/02/2023.
//

import SwiftUI

struct PlayerList: View {
    var body: some View {
        List (basket) { basket in
            NavigationLink {
                PlayerDetail(basket: basket)
            } label: {
                PlayerRow(basket: basket)
            }
        }
        .navigationTitle("BCMF")
    }
}

struct PlayerList_Previews: PreviewProvider {
    static var previews: some View {
       PlayerList()
    }
}
