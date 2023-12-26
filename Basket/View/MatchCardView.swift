//
//  MatchCardView.swift
//  Basket
//
//  Created by Thibault Giraudon on 25/12/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct MatchCardView: View {
    @StateObject var viewModel = EventViewModel()
    @State var event: Event

    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: event.date)
    }
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .foregroundStyle(Color(.systemGray5))
                .frame(width: UIScreen.main.bounds.width - 20, height: 200)
                .shadow(radius: 8)
            VStack {
                HStack {
                    Text(formattedDate)
                }
                HStack {
                    VStack {
                        WebImage(url: URL(string: event.team1_image))
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                        Text(event.team1_name)
                    }
                    Text("VS")
                        .fontWeight(.bold)
                        .padding(.horizontal, 50)
                    VStack {
                        WebImage(url: URL(string: event.team2_image))
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                        Text(event.team2_name)
                    }
                }
            }
        }
    }
}

#Preview {
    MatchCardView(event: Event(title: "",
                               description: "",
                               team1_name: "Montbrison",
                               team2_name: "AL Neulise",
                               team1_image: "https://firebasestorage.googleapis.com/v0/b/bcmf-d3d8a.appspot.com/o/logo-teams%2Fbcmf%402x.jpg?alt=media&token=84acc696-597b-4fbc-bdd2-24e156d349e9",
                               team2_image: "https://firebasestorage.googleapis.com/v0/b/bcmf-d3d8a.appspot.com/o/logo-teams%2Fal-neulise.jpg?alt=media&token=7bb6663f-5263-48d4-9e88-21b78af83423",
                               date: Date(),
                               hour: Date(),
                               type: "match"))
}
