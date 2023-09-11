//
//  RankingTitle.swift
//  Basket
//
//  Created by Thibault Giraudon on 03/03/2023.
//

import SwiftUI

struct RankingTitle: View {
    var body: some View {
        HStack {
            Text("Equipe")
                .frame(width: UIScreen.main.bounds.width * (0.43))
            Text("Pts")
                .frame(width: UIScreen.main.bounds.width * (0.06))
            Text("J")
                .frame(width: UIScreen.main.bounds.width * (0.03))
            Text("G")
                .frame(width: UIScreen.main.bounds.width * (0.03))
            Text("P")
                .frame(width: UIScreen.main.bounds.width * (0.03))
            Text("N")
                .frame(width: UIScreen.main.bounds.width * (0.03))
            Text("M")
                .frame(width: UIScreen.main.bounds.width * (0.06))
            Text("E")
                .frame(width: UIScreen.main.bounds.width * (0.06))
            Text("D")
                .frame(width: UIScreen.main.bounds.width * (0.06))
        }
        .font(.system(size: 7))
        .multilineTextAlignment(.leading)
        .ignoresSafeArea()
    }
}

struct RankingTitle_Previews: PreviewProvider {
    static var previews: some View {
        RankingTitle()
    }
}
