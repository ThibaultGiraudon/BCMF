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
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: planning.date)
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .foregroundStyle(Color(.systemGray5))
                .frame(width:UIScreen.main.bounds.width - 50, height: 200)
                .shadow(radius: 8)
            VStack {
                Text(formattedDate)
                Text(planning.description)
                HStack(alignment: .center) {
                    VStack {
                        WebImage(url: URL(string: planning.image1))
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                        Text(planning.team1 + "\n")
                            .frame(width: 100)
                            .font(.system(size: 14))
                            .lineLimit(2)
                    }
                    Text(planning.result)
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                    VStack {
                        WebImage(url: URL(string: planning.image2))
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                        Text(planning.team2 + "\n")
                            .frame(width: 100)
                            .font(.system(size: 14))
                            .lineLimit(2)
                    }
                }
            }
            .fontWeight(.bold)
        }
    }
}

struct ScoreCardView_Previews: PreviewProvider {
    static var previews: some View {
        let planning = Planning(date: Date.now, 
                                hour: Date.now,
                                team1: "MONTBRISON",
                                team2: "AL Neulise",
                                result: "03 - 03", image1: "https://firebasestorage.googleapis.com/v0/b/bcmf-d3d8a.appspot.com/o/logo-teams%2Fbcmf-modified.png?alt=media&token=0ca00941-e9fe-458d-90e4-0ef195432d59",
                                image2: "https://firebasestorage.googleapis.com/v0/b/bcmf-d3d8a.appspot.com/o/al-neulise.jpg?alt=media&token=a22baa09-cc7d-4def-a0f7-b0d62fa823ca",
                                description: "LF2, Journée 11, Group A",
                                sort: 11)
        ScoreCardView(planning: planning)
    }
}
