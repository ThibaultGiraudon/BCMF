//
//  ScoreCardView.swift
//  Basket
//
//  Created by Thibault Giraudon on 22/12/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct ScoreCardView: View {
    var planning: Planning
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .foregroundStyle(Color(.systemGray5))
                .frame(width:UIScreen.main.bounds.width - 50, height: 150)
                .shadow(radius: 8)
            HStack {
                WebImage(url: URL(string: planning.image1))
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                if planning.result == "-" {
                    Text("VS")
                }
                else {
                    Text(planning.result)
                }
                WebImage(url: URL(string: planning.image2))
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            }
        }
    }
}

struct ScoreCardView_Previews: PreviewProvider {
    static var previews: some View {
        let planning = Planning(date: Date.now, 
                                hour: Date.now,
                                team1: "MONTBRISON FEMININE BC - 2",
                                team2: "IE FRAISSE-UNIEUX BASKET 42 - 2",
                                result: "03-03", image1: "https://firebasestorage.googleapis.com/v0/b/bcmf-d3d8a.appspot.com/o/bcmf%402x.jpg?alt=media&token=2bf8f095-5f3b-4d33-a4e8-2ef67583e190",
                                image2: "https://firebasestorage.googleapis.com/v0/b/bcmf-d3d8a.appspot.com/o/al-neulise.jpg?alt=media&token=a22baa09-cc7d-4def-a0f7-b0d62fa823ca",
                                sort: 11)
        ScoreCardView(planning: planning)
    }
}
