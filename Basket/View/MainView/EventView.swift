//
//  EventView.swift
//  Basket
//
//  Created by Thibault Giraudon on 27/12/2023.
//

import SwiftUI
import EventKit
import SDWebImageSwiftUI

struct EventView: View {
    var event: Event
    @State var formType: FormType?
    @State private var presentEditView = false
    @State private var isAuthorized = false
    @State private var showAlert = false
    @State private var added = false
    
    @StateObject private var vm = EventViewModel()
    var body: some View {
        HStack {
            Spacer()
            if (event.type == "match") {
                MatchCardView(event: event)
            }
            else {
                if let image = event.image {
                    WebImage(url: URL(string: image))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300)
                }
            }
            Spacer()
        }
        .swipeActions(edge: .trailing) {
            Button("Supprimer") {
                Task {
                    do {
                        try await vm.deleteItem(event)
                        print("Event deleted")
                    } catch {
                        vm.error = error.localizedDescription
                    }
                }
            }
            .tint(.red)
            Button("Ajouter au calendrier") {
                requestCalendarAccess(event)
            }
            .tint(.green)
        }
        .swipeActions(edge: .leading) {
            Button("Modifier") {
                formType = .edit(event)
            }
            .tint(.blue)
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
        .sheet(item: $formType) { type in
            NavigationStack {
                EventEditView(viewModel: .init(formType: type))
            }
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
                calendarEvent.notes = event.info
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
        EventView(event: Event(title: "Montbrison VS Andrezieux", description: "", info: "", team1_name: "Montbrison", team2_name: "Andrezieux", team1_image: "https://firebasestorage.googleapis.com:443/v0/b/bcmf-d3d8a.appspot.com/o/logo-teams%2Fbcmf-modified.png?alt=media&token=0ca00941-e9fe-458d-90e4-0ef195432d59", team2_image: "https://firebasestorage.googleapis.com:443/v0/b/bcmf-d3d8a.appspot.com/o/logo-teams%2Flogo-abls.png?alt=media&token=cca3b0af-3adf-40ef-a330-02b7a8294469", score: "83 - 69", date: Date.now, hour: Date.now, type: "match"))
    }
}
