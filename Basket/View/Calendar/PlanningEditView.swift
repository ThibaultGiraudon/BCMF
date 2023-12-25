//
//  PlanningEditView.swift
//  Basket
//
//  Created by Thibault Giraudon on 26/08/2023.
//

import SwiftUI

struct PlanningEditView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State var presentActionSheet = false
    @StateObject var viewModel = PlanningViewModel()
    var mode: Mode = .new
    
    var body: some View {
        Form {
            Section(header: Text("Date")) {
                TextField("Equipe 1", text: $viewModel.planning.team1)
                TextField("Equipe 2", text: $viewModel.planning.team2)
                DatePicker("Date", selection: $viewModel.planning.date, displayedComponents: [.date])
                DatePicker("Heure", selection: $viewModel.planning.hour, displayedComponents: [.hourAndMinute])
                TextField("Resultat", text: $viewModel.planning.result)
                TextField("Ordre", value: $viewModel.planning.sort, formatter: NumberFormatter())
            }
            if mode == .edit {
                Section {
                    Button("Supprimer match") { self.presentActionSheet.toggle() }
                        .foregroundColor(.red)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle(mode == .new ? "Nouveau match" : "Editer match")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
        leading:
            Button(action: { self.handleCancelTapped() }) {
            Text("Cancel")
            },
        trailing:
            Button(action: { self.handleDoneTapped() }) {
                Text(mode == .new ? "Done" : "Save")
            }
            .disabled(!viewModel.modified)
        )
        .confirmationDialog("", isPresented: $presentActionSheet) {
            Button(role: .destructive, action: { self.handleDeleteTapped() }) {
                Text("Delete match")
            }
        }
    }
    
    func handleCancelTapped() {
        dismiss()
    }
      
    func handleDoneTapped() {
        self.viewModel.handleDoneTapped()
        dismiss()
    }
      
    func dismiss() {
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func handleDeleteTapped() {
        viewModel.handleDeleteTapped()
        self.dismiss()
    }
}

struct PlanningEditView_Previews: PreviewProvider {
    static var previews: some View {
        let planning = Planning(
            date: Date(), // Replace with your actual date value
            hour: Date(), // Replace with your actual date value
            team1: "12",
            team2: "12",
            result: "12-12",
            image1: "https://firebasestorage.googleapis.com/v0/b/bcmf-d3d8a.appspot.com/o/bcmf%402x.jpg?alt=media&token=2bf8f095-5f3b-4d33-a4e8-2ef67583e190",
            image2: "",
            sort: 12
        )
        let planningViewModel = PlanningViewModel(planning: planning)
        NavigationView {
            PlanningEditView(viewModel: planningViewModel, mode: .edit)
        }
    }
}
