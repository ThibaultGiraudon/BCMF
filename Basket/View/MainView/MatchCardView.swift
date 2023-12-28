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
                .foregroundStyle(event.team1_name == "Montbrison" ? Color(.systemGray5) : .green)
                .frame(width: UIScreen.main.bounds.width - 20, height: 200)
                .shadow(radius: 8)
                .clipShape(RoundedRectangle(cornerRadius: 25.0))

            Triangle()
                .fill(event.team1_name == "Montbrison" ? .green : Color(.systemGray5))
                .frame(width: 270, height: 200)
                .offset(x: -UIScreen.main.bounds.width / 2 + 100, y: 0)
                .clipped()

            Triangle()
                .fill(event.team1_name == "Montbrison" ? .green : Color(.systemGray5))
                .frame(width: 270, height: 200)
                .offset(x: -UIScreen.main.bounds.width / 2 + 75, y: 100)
                .clipped()

            RoundedRectangle(cornerRadius: 25.0)
                .foregroundStyle(event.team1_name == "Montbrison" ? .green : Color(.systemGray5))
                .frame(width: 90, height: 200)
                .offset(x: -UIScreen.main.bounds.width / 2 + 55, y: 0)
            VStack {
                Text(formattedDate)
                Text(event.info)
                HStack {
                    VStack {
                        WebImage(url: URL(string: event.team1_image))
                            .resizable()
                            .scaledToFit()
                            .frame(width:100)
                        Text(event.team1_name)
                    }
                    if event.score != "0 - 0" {
                        Text(event.score)
                            .padding(.horizontal, 30)
                    }
                    else {
                        Text("VS")
                            .fontWeight(.bold)
                            .padding(.horizontal, 50)
                    }
                    VStack {
                        WebImage(url: URL(string: event.team2_image))
                            .resizable()
                            .scaledToFit()
                            .frame(width:100)
                        Text(event.team2_name)
                    }
                }
            }
            .fontWeight(.bold)
        }
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))

        return path
    }
}


#Preview {
    MatchCardView(event: Event(title: "",
                               description: "",
                               info: "",
                               team1_name: "AL Neulise",
                               team2_name: "Montbrison",
                               team1_image: "https://firebasestorage.googleapis.com/v0/b/bcmf-d3d8a.appspot.com/o/logo-teams%2Fal-neulise.jpg?alt=media&token=7bb6663f-5263-48d4-9e88-21b78af83423",
                               team2_image: "https://firebasestorage.googleapis.com/v0/b/bcmf-d3d8a.appspot.com/o/logo-teams%2Fbcmf-modified.png?alt=media&token=0ca00941-e9fe-458d-90e4-0ef195432d59",
                               score: "0 - 0",
                               date: Date(),
                               hour: Date(),
                               type: "match"))
}
