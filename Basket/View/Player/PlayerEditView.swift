//
//  PlayerEditView.swift
//  Basket
//
//  Created by Thibault Giraudon on 25/08/2023.
//

import SwiftUI

enum Mode {
    case new
    case edit
}

enum Action {
    case delete
    case done
    case cancel
}

struct PlayerEditView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State var presentActionSheet = false
    
    @ObservedObject var viewModel = PlayerViewModel()
    var mode: Mode = .new
    var completionHandler: ((Result<Action, Error>) -> Void)?
  
  var body: some View {
    NavigationView {
        Form {
          Section(header: Text("Player")) {
              TextField("Nom", text: $viewModel.player.name)
              TextField("Numero", value: $viewModel.player.number, formatter: NumberFormatter())
              TextField("Post", text: $viewModel.player.post)
              TextField("Taille", text: $viewModel.player.size)
              TextField("Total", text: $viewModel.player.total)
              TextField("Description", text: $viewModel.player.description)
              TextField("Image", text: $viewModel.player.imageURL)
          }
            
            if mode == .edit {
              Section {
                Button("Delete player") { self.presentActionSheet.toggle() }
                  .foregroundColor(.red)
              }
            }
      }
      .navigationTitle(mode == .new ? "New player" : viewModel.player.name)
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
              Text("Delete Player")
          }
          .foregroundColor(.red)
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
  
    func handleDeleteTapped() {
        viewModel.handleDeleteTapped()
        self.dismiss()
        self.completionHandler?(.success(.delete))
    }
    
  func dismiss() {
    self.presentationMode.wrappedValue.dismiss()
  }
}

struct BookEditView_Previews: PreviewProvider {
  static var previews: some View {
    let player = Player(name: "", number: 12, size: "", total: "", imageURL: "", post: "", description: "")
    let playerViewModel = PlayerViewModel(player: player)
    return PlayerEditView(viewModel: playerViewModel)
  }
}
