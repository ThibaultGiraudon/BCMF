//
//  RankingRowView.swift
//  Basket
//
//  Created by Thibault Giraudon on 26/08/2023.
//

import SwiftUI

struct RankingRowView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var club: Club
    var body: some View {
        HStack{
            Text(club.name)
                .frame(width: UIScreen.main.bounds.width * (0.43))
            Text(club.pts)
                .frame(width: UIScreen.main.bounds.width * (0.06))
            Text(club.play)
                .frame(width: UIScreen.main.bounds.width * (0.03))
            Text(club.win)
                .frame(width: UIScreen.main.bounds.width * (0.03))
            Text(club.loose)
                .frame(width: UIScreen.main.bounds.width * (0.03))
            Text(club.null)
                .frame(width: UIScreen.main.bounds.width * (0.03))
            Text(club.scored)
                .frame(width: UIScreen.main.bounds.width * (0.06))
            Text(club.taken)
                .frame(width: UIScreen.main.bounds.width * (0.06))
            Text(club.diff)
                .frame(width: UIScreen.main.bounds.width * (0.06))
        }
        .multilineTextAlignment(.leading)
        .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
        .font(.system(size: 7))
    }
}

struct RankingRowView_Previews: PreviewProvider {
    static var previews: some View {
        let club = Club(name: "Montbrison", image:"", pts: "42", play: "42", win: "42", loose: "42", null: "42", scored: "42", taken: "42", diff: "42", rank: "42")
        RankingRowView(club: club)
    }
}
