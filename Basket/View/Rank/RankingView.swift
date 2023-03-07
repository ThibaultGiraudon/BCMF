//
//  RankingView.swift
//  Basket
//
//  Created by Thibault Giraudon on 27/02/2023.
//

import SwiftUI

struct RankingView: View {
    @ObservedObject private var viewModel = ViewModel()
    
    var body: some View {
        VStack () {
            RankTitle()
            Divider()
            ForEach(viewModel.clubs) { club in
                HStack{
                    Text(club.name)
                        .multilineTextAlignment(.leading)
                        .frame(width: UIScreen.main.bounds.height * (0.20))
                        .font(.system(size: 7))
                    Text(club.pts)
                        .multilineTextAlignment(.leading)
                        .frame(width: UIScreen.main.bounds.height * (0.02))
                        .font(.system(size: 7))
                    Text(club.play)
                        .multilineTextAlignment(.leading)
                        .frame(width: UIScreen.main.bounds.height * (0.02))
                        .font(.system(size: 7))
                    Text(club.win)
                        .multilineTextAlignment(.leading)
                        .frame(width: UIScreen.main.bounds.height * (0.02))
                        .font(.system(size: 7))
                    Text(club.loose)
                        .multilineTextAlignment(.leading)
                        .frame(width: UIScreen.main.bounds.height * (0.02))
                        .font(.system(size: 7))
                    Text(club.null)
                        .multilineTextAlignment(.leading)
                        .frame(width: UIScreen.main.bounds.height * (0.02))
                        .font(.system(size: 7))
                    Text(club.scored)
                        .multilineTextAlignment(.leading)
                        .frame(width: UIScreen.main.bounds.height * (0.02))
                        .font(.system(size: 7))
                    Text(club.taken)
                        .multilineTextAlignment(.leading)
                        .frame(width: UIScreen.main.bounds.height * (0.02))
                        .font(.system(size: 7))
                    Text(club.diff)
                        .multilineTextAlignment(.leading)
                        .frame(width: UIScreen.main.bounds.height * (0.02))
                        .font(.system(size: 7))
                }
                Divider()
            }
        }.onAppear() {
            self.viewModel.fetchData()
            }
    }
}

struct RankingView_Previews: PreviewProvider {
    static var previews: some View {
        RankingView()
    }
}
