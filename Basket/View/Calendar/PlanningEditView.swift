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
    @State private var ranks = ["LF1", "LF2", "N1", "N2", "N3", "R1", "R2", "R3", "R4", "D1", "D2", "D3", "D4"]
    @State private var groups = "ABCDEF"
    @State private var selectedRank = "LF2"
    @State private var selectedDay = 1
    @State private var selectedGroup = "A"
    @StateObject var viewModel = PlanningViewModel()
    var mode: Mode = .new
    
    var body: some View {
        Form {
            Section(header: Text("Date")) {
                TextField("Equipe 1", text: $viewModel.planning.team1)
                TextField("Equipe 2", text: $viewModel.planning.team2)
                DatePicker("Date", selection: $viewModel.planning.date, displayedComponents: [.date])
                DatePicker("Heure", selection: $viewModel.planning.date, displayedComponents: [.hourAndMinute])
                TextField("Resultat", text: $viewModel.planning.result)
                TextField("Ordre", value: $viewModel.planning.sort, formatter: NumberFormatter())
                Picker("Niveau", selection: $selectedRank) {
                    ForEach(ranks, id: \.self) { rank in
                            Text(rank)
                    }
                }
                Picker("Journée", selection: $selectedDay) {
                    ForEach(1..<23) { index in
                            Text("\(index)")
                    }
                }
                Picker("Groupe", selection: $selectedGroup) {
                    ForEach(Array(groups), id: \.self) { char in
                            Text(String(char))
                    }
                }
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
            Button{
                self.handleDoneTapped()
                viewModel.planning.description = selectedRank + ", Journée " + String(selectedDay + 1)
                viewModel.planning.description += ", Group " + String(selectedGroup)
                print(viewModel.planning.description)
            } label: {
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
            image1: "https://firebasestorage.googleapis.com/v0/b/bcmf-d3d8a.appspot.com/o/logo-teams%2Fbcmf-modified.png?alt=media&token=0ca00941-e9fe-458d-90e4-0ef195432d59",
            image2: "",
            description: "LF2, Journée 11, Group A",
            sort: 12
        )
        let planningViewModel = PlanningViewModel(planning: planning)
        NavigationView {
            PlanningEditView(viewModel: planningViewModel, mode: .edit)
        }
    }
}
