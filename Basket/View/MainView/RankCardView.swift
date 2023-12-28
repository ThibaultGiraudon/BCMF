//
//  RankCardView.swift
//  Basket
//
//  Created by Thibault Giraudon on 26/12/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct RankCardView: View {
    var club: Club
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .foregroundStyle(Color(.systemGray5))
                .frame(width: UIScreen.main.bounds.width - 40, height: 250)
                .shadow(radius: 8)
            VStack {
                HStack(spacing: 0) {
                    Text("#\(club.rank)")
                        .padding(8)
                        .foregroundStyle(.white)
                        .font(.system(size: 25))
                        .fontWeight(.heavy)
                        .background(.green)
                        .ignoresSafeArea()
                    Text("\(club.win)V-\(club.loose)D")
                        .padding(8)
                        .fontWeight(.heavy)
                        .font(.system(size: 25))
                        .foregroundStyle(.green)
                        .background(.white)
                        .ignoresSafeArea()
                }
                if let image = club.image {
                    WebImage(url: URL(string: image))
                        .resizable()
                        .scaledToFit()
                        .frame(width:100)
                }
                Text(club.name)
                    .font(.system(size: 30))
                    .fontWeight(.bold)
            }
        }
    }
}

#Preview {
    RankCardView(club: Club(name: "Montbrison",
                            pts: "0", play: "0", win: "7", loose: "3", null: "0", scored: "0", taken: "0", diff: "0", rank: "1",
                            image:"https://firebasestorage.googleapis.com/v0/b/bcmf-d3d8a.appspot.com/o/logo-teams%2Fbcmf-modified.png?alt=media&token=0ca00941-e9fe-458d-90e4-0ef195432d59"))
}
