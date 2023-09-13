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
//        .toolbar {
//            ToolbarItem(placement: .confirmationAction) {
//                Menu {
//                    Button(action: { self.presentAddClubSheet.toggle() }) {
//                        Label("Add", systemImage: "plus")
//                    }
//                    Button(action: { self.presentLoginSheet.toggle() }) {
//                        Label("Profil", systemImage: "person.circle")
//                    }
//                    HStack {
//                        Toggle("Mode sombre", isOn: $gs.isDarkMode)
//                    }
//                }
//                label: {
//                    Label("Settings", systemImage: "gearshape.fill")
//                        .foregroundColor(.green)
//                }
//            }
//        }
//        .sheet(isPresented: self.$presentLoginSheet) {
//            LoginView()
//        }
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
