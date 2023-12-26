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
    @StateObject var vm = EventViewModel()
    @State private var filter: FilterType?
    @State private var isAuthorized = false
    @State private var showAlert = false
    @State private var added = false

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
        Group {
            HStack {
                Button{
                    filter = (filter == .passed) ? .none : .passed
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
                }
                .foregroundStyle(filter == .passed ? .green : .black)
                .buttonStyle(.borderless)
                Button {
                    filter = (filter == .future) ? .none : .future
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
                }
                .foregroundStyle(filter == .future ? .green : .black)
                .buttonStyle(.borderless)
                Button {
                    filter = (filter == .match) ? .none : .match
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
                }
                .foregroundStyle(filter == .match ? .green : .black)
                .buttonStyle(.borderless)
            }
            Section {
                ForEach(filteredEvents) { event in
                    Group {
                        if (event.type == "match") {
                            MatchCardView(event: event)
                        }
                        else {
                            if let image = event.image {
                                WebImage(url: URL(string: image))
                                    .resizable()
                                    .frame(width: 300, height: 300)
                            }
                        }
                    }
                    .swipeActions(edge: .trailing) {
                        Button("Supprimer") {
                            Task {
                                do {
                                    try await vm.deleteItem(event.id)
                                    print("Event deleted")
                                } catch {
                                    vm.error = error.localizedDescription
                                }
                            }
                        }
                        .tint(.red)
                    }
                    .swipeActions(edge: .leading) {
                        Button("Ajouter au calendrier") {
                            requestCalendarAccess(event)
                        }
                        .tint(.green)
                    }
                    .alert("Evenenent ajouté au calendrier avec succes", isPresented: $added) {
                        Button("Ok", role: .cancel) { added = false}
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Accès refusé"),
                            message: Text("Vous avez refusé l'accès au calendrier. Pour autoriser l'accès, veuillez accéder aux paramètres de l'application."),
                            primaryButton: .default(Text("OK")),
                            secondaryButton: .cancel()
                        )
                    }
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
}
