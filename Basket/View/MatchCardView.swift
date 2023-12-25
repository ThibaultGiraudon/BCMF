//
//  MatchCardView.swift
//  Basket
//
//  Created by Thibault Giraudon on 25/12/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct MatchCardView: View {
    @State var event: Event
    private let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            return formatter
        }()
    var body: some View {
        VStack {
            Text("\(event.date, formatter: dateFormatter)")
            Text(event.date, style: .date)
        }
    }
}

#Preview {
    MatchCardView(event: Event(title: "",
                               description: "",
                               team1_image: "https://firebasestorage.googleapis.com/v0/b/bcmf-d3d8a.appspot.com/o/logo-teams%2Fbcmf%402x.jpg?alt=media&token=84acc696-597b-4fbc-bdd2-24e156d349e9",
                               team2_image: "https://firebasestorage.googleapis.com/v0/b/bcmf-d3d8a.appspot.com/o/logo-teams%2Fal-neulise.jpg?alt=media&token=7bb6663f-5263-48d4-9e88-21b78af83423",
                               date: Date(),
                               hour: Date(),
                               type: "match"))
}
