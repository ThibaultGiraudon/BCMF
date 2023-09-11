//
//  RankingEditView.swift
//  Basket
//
//  Created by Thibault Giraudon on 26/08/2023.
//

import SwiftUI

struct RankingEditView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State var presentActionSheet = false
    @StateObject var viewModel = RankingViewModel()
    var mode: Mode = .new
    
    var body: some View {
              Form {
                Section(header: Text("Club")) {
                  TextField("Nom", text: $viewModel.club.name)
                  TextField("Point", text: $viewModel.club.pts)
                  TextField("Match joué", text: $viewModel.club.play)
                  TextField("Match gagné", text: $viewModel.club.win)
                  TextField("Match perdu", text: $viewModel.club.loose)
                  TextField("Match nul", text: $viewModel.club.null)
                  TextField("Point marqué", text: $viewModel.club.scored)
                  TextField("Point encaissé", text: $viewModel.club.taken)
                  TextField("Différence", text: $viewModel.club.diff)
                  TextField("Rang", text: $viewModel.club.rank)
                }
                  if mode == .edit {
                      Section {
                          Button("Supprimer le club") { self.presentActionSheet.toggle () }
                              .foregroundColor(.red)
                      }
                  }
              }
              .navigationBarBackButtonHidden(true)
              .navigationTitle(mode == .new ? "Nouveau club" : viewModel.club.name)
              .navigationBarTitleDisplayMode(mode == .new ? .inline : .large)
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
                      Text("Delete club")
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

struct RankingEditView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RankingEditView()
        }
    }
}
