//
//  RankingView.swift
//  Basket
//
//  Created by Thibault Giraudon on 27/02/2023.
//

import SwiftUI

struct RankingView: View {
    private var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }

    private var sortedclub: [Club] {
        club.sorted { $0.rank < $1.rank }
    }
    var body: some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            VStack {
                RankTitle()
                Divider()
                ForEach(sortedclub) { sortedclub in
                    RankRow(club: sortedclub)
                    Divider()
                }
            }
        }
        else {
            VStack {
                Spacer()
                Table(club) {
                    TableColumn("Equipe", value: \.name)
                        .width(UIScreen.main.bounds.height * (0.25))
                    TableColumn("Pts", value: \.pts)
                    TableColumn("J", value: \.play)
                    TableColumn("G", value: \.win)
                    TableColumn("P", value: \.loose)
                    TableColumn("N", value: \.null)
                    TableColumn("M", value: \.scored)
                    TableColumn("E", value: \.taken)
                    TableColumn("D", value: \.diff)
                }
            }
        }
    }
}

struct RankingView_Previews: PreviewProvider {
    static var previews: some View {
        RankingView()
    }
}
