//
//  RankingingView.swift
//  Basket
//
//  Created by Thibault Giraudon on 27/02/2023.
//

import SwiftUI

struct RankingView: View {
    @ObservedObject private var viewModel = ClubsViewModel()
    @State var presentAddClubSheet = false
    @State var presentLoginSheet = false
    
    var body: some View {
        VStack () {
            RankingTitle()
            Divider()
            ForEach(viewModel.clubs) { club in
                RankingRowView(club: club)
                Divider()
            }
        }
        .navigationTitle("Classement")
        .onAppear() {
            self.viewModel.listenToItems()
        }
    }
}

struct RankingingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RankingView()
        }
    }
}
