//
//  RankTitle.swift
//  Basket
//
//  Created by Thibault Giraudon on 03/03/2023.
//

import SwiftUI

struct RankTitle: View {
    var body: some View {
        HStack {
            Text(" Equipe")
                .frame(width: UIScreen.main.bounds.height * (0.20))
                .font(.system(size: 7))
            Text("Pts")
                .frame(width: UIScreen.main.bounds.height * (0.02))
                .font(.system(size: 7))
            Text("J ")
                .frame(width: UIScreen.main.bounds.height * (0.02))
                .font(.system(size: 7))
            Text("G")
                .frame(width: UIScreen.main.bounds.height * (0.02))
                .font(.system(size: 7))
            Text("P")
                .frame(width: UIScreen.main.bounds.height * (0.02))
                .font(.system(size: 7))
            Text("N")
                .frame(width: UIScreen.main.bounds.height * (0.02))
                .font(.system(size: 7))
            Text("M")
                .frame(width: UIScreen.main.bounds.height * (0.02))
                .font(.system(size: 7))
            Text("E  ")
                .frame(width: UIScreen.main.bounds.height * (0.02))
                .font(.system(size: 7))
            Text("D    ")
                .frame(width: UIScreen.main.bounds.height * (0.02))
                .font(.system(size: 7))
        }
        .ignoresSafeArea()
    }
}

struct RankTitle_Previews: PreviewProvider {
    static var previews: some View {
        RankTitle()
    }
}
