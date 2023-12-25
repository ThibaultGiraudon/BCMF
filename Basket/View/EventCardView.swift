//
//  EventCardView.swift
//  Basket
//
//  Created by Thibault Giraudon on 23/12/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct EventCardView: View {
    @StateObject var viewModel = EventsViewModel()
    @State private var filter: FilterType?

    enum FilterType {
        case passed, future, match
    }

    var filteredEvents: [Event] {
        switch filter {
        case .passed:
            return viewModel.items.filter { $0.date < Date() }
        case .future:
            return viewModel.items.filter { $0.date >= Date() }
        case .match:
            return viewModel.items.filter { $0.type == "match" }
        case .none:
            return viewModel.items
        }
    }
    var body: some View {
        VStack {
            HStack {
                Button{
                    if filter == .passed {
                        filter = .none
                    }
                    else {
                        filter = .passed
                    }
                } label: {
                    VStack {
                        ZStack {
                            Circle()
                                .frame(width: 50, height: 50)
                                .foregroundStyle(Color(.systemGray5))
                            Image(systemName: "gobackward")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                        Text("Passe")
                    }
                    .foregroundStyle(filter == .passed ? .green : .black)
                }
                Button {
                    if filter == .future {
                        filter = .none
                    }
                    else {
                        filter = .future
                    }
                } label: {
                    VStack {
                        ZStack {
                            Circle()
                                .frame(width: 50, height: 50)
                                .foregroundStyle(Color(.systemGray5))
                            Image(systemName: "goforward")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                        Text("A venir")
                    }
                    .foregroundStyle(filter == .future ? .green : .black)
                }
                Button {
                    if filter == .match {
                        filter = .none
                    }
                    else {
                        filter = .match
                    }
                } label: {
                    VStack {
                        ZStack {
                            Circle()
                                .frame(width: 50, height: 50)
                                .foregroundStyle(Color(.systemGray5))
                            Image(systemName: "basketball")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                        Text("Match")
                    }
                    .foregroundStyle(filter == .match ? .green : .black)
                }
            }
            ForEach(filteredEvents) { event in
                if (event.type == "match") {
                    HStack {
                        WebImage(url: URL(string: event.team1_image))
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                        Text("VS")
                        WebImage(url: URL(string: event.team2_image))
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                    }
                }
                else {
                    if let image = event.image {
                        WebImage(url: URL(string: image))
                            .resizable()
                            .frame(width: 300, height: 300)
                    }
                }
            }
        }
        .onAppear() {
            viewModel.listenToItems()
        }
    }
}

#Preview {
    EventCardView()
}
