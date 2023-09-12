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
                TextField("Date", text: $viewModel.planning.date)
                TextField("Heure", text: $viewModel.planning.hour)
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
        let planning = Planning(date: "12", hour: "12", team1: "12", team2: "12", result: "12-12", sort: 12)
        let planningViewModel = PlanningViewModel(planning: planning)
        NavigationView {
            PlanningEditView(viewModel: planningViewModel, mode: .edit)
        }
    }
}
