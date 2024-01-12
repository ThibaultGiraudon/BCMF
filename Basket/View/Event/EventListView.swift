//
//  EventCardView.swift
//  Basket
//
//  Created by Thibault Giraudon on 23/12/2023.
//

import SwiftUI
import EventKit
import SDWebImageSwiftUI

struct EventListView: View {
    @StateObject var viewModel = EventsViewModel()
    @State var formType: FormType?
    @StateObject var vm = EventViewModel()
    @State private var filter = FilterType.future
    @State private var presentEditView = false
    @State private var isAuthorized = false
    @State private var showAlert = false
    @State private var added = false

    enum FilterType: String, CaseIterable, Identifiable {
        case passed, future, match
        var name: String {
            switch self {
            case .passed:
                "Passé"
            case .future:
                "A venir"
            case .match:
                "Match"
            }
        }
        var id: Self { self }
    }

    var filteredEvents: [Event] {
        switch filter {
        case .passed:
            return viewModel.events.reversed().filter { $0.date < Date() }
        case .future:
            return viewModel.events.filter { $0.date >= Date() }
        case .match:
            return viewModel.events.filter { $0.type == "match" }
        }
    }
    var body: some View {
        Section {
            VStack {
                HStack {
                    Text("Evenement")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .padding()
                    Spacer()
                }
                Picker("Filtre", selection: $filter) {
                    ForEach(FilterType.allCases) { filter in
                        Text(filter.name)
                    }
                }
            }
            if filteredEvents.count == 0 {
                Text("Aucun evenement")
            }
            else {
                ForEach(filteredEvents) { event in
                    EventView(event: event)
                }
            }
        }
        .onAppear {
            viewModel.listenToItems()
        }
    }
}

#Preview {
    List {
        EventListView()
    }
    .listStyle(.inset)
}
