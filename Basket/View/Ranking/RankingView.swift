//
//  RankingingView.swift
//  Basket
//
//  Created by Thibault Giraudon on 27/02/2023.
//

import SwiftUI

struct RankingView: View {
    @ObservedObject private var viewModel = RankingsViewModel()
    @State var presentAddClubSheet = false
    @State var presentLoginSheet = false
    @ObservedObject var gs = GlobalState.shared
    
    var body: some View {
        VStack () {
            RankingTitle()
            Divider()
            ForEach(viewModel.clubs) { club in
                if gs.isAuthenticated {
                    NavigationLink(destination : RankingEditView(viewModel: RankingViewModel(club: club), mode: .edit)) {
                        RankingRowView(club: club)
                    }
                    .foregroundColor(.black)
                }
                else {
                    RankingRowView(club: club)
                }
                Divider()
            }
        }
        .navigationTitle("Classement")
        .sheet(isPresented: $gs.presentAddSheet) {
            NavigationView {
                RankingEditView()
            }
        }
        .onAppear() {
            self.viewModel.subscribe()
        }
        .preferredColorScheme(gs.isDarkMode == true ? .dark : .light)
    }
}

struct RankingingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RankingView()
        }
    }
}
