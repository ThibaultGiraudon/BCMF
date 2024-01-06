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
        .onAppear() {
            viewModel.listenToItems()
            checkCalendarAuthorization()
        }
    }
    

    private func checkCalendarAuthorization() {
        switch EKEventStore.authorizationStatus(for: .event) {
        case .authorized, .writeOnly:
            isAuthorized = true
        case .denied, .restricted, .notDetermined:
            isAuthorized = false
        case .fullAccess:
            isAuthorized = true
        @unknown default:
            isAuthorized = false
        }
    }

    private func requestCalendarAccess(_ event: Event) {
        let eventStore = EKEventStore()

        eventStore.requestWriteOnlyAccessToEvents() { (granted, error) in
            if granted && error == nil {
                isAuthorized = true
                let calendarEvent = EKEvent(eventStore: eventStore)
                calendarEvent.title = event.title
                calendarEvent.startDate = event.date
                calendarEvent.endDate = event.date.addingTimeInterval(3600)
                calendarEvent.notes = event.description
                calendarEvent.calendar = eventStore.defaultCalendarForNewEvents

                do {
                    try eventStore.save(calendarEvent, span: .thisEvent)
                    print("Événement ajouté au calendrier avec succès.")
                    added = true
                } catch {
                    print("Erreur lors de l'ajout de l'événement au calendrier: \(error.localizedDescription)")
                }
            } else {
                isAuthorized = false
                showAlert = true
                print("L'accès au calendrier a été refusé.")
            }
        }
    }
}

#Preview {
    List {
        EventListView()
    }
    .listStyle(.inset)
}
