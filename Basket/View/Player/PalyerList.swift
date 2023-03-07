//
//  PlayerList.swift
//  Basket
//
//  Created by Thibault Giraudon on 27/02/2023.
//

import SwiftUI

struct PlayerList: View {
    @ObservedObject private var viewModel = ViewModel()
    var body: some View {
        List (viewModel.players) { player in
            NavigationLink {
                ScrollView{
                    VStack {
                        Image("bcmf")
                            .ignoresSafeArea(edges: .top)
                            .frame(height: 300)
                        PlayerImage(url: player.imageURL)
                            .offset(y: -130)
                            .padding(.bottom, -130)
                        
                        VStack(alignment: .leading) {
                            Text(player.name)
                                .font(.title)
                            Text(player.total)
                            Divider()
                            HStack {
                                Text("Post \(player.post)")
                                Spacer()
                                Text("Taille : \(player.size)")
                            }
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            if !(player.description.contains("(null)")) {
                                Divider()
                                Text(player.description)
                            }
                        }
                        .padding()
                    }
                    .navigationTitle(player.name)
                    .navigationBarTitleDisplayMode(.inline)
                    .ignoresSafeArea()
                }
            } label: {
                HStack {
                    Image(player.imageURL)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 35, height: 45, alignment: .bottom)
                        .mask(Rectangle().edgesIgnoringSafeArea(.top))
                    Text(player.name)
                    
                    Spacer()
                }
            }
        }
        .navigationTitle("BCMF")
        .onAppear() {
            self.viewModel.fetchData()
        }
    }
}

struct PlayerList_Previews: PreviewProvider {
    static var previews: some View {
       PlayerList()
    }
}
