//
//  PlayerEditView.swift
//  Basket
//
//  Created by Thibault Giraudon on 25/08/2023.
//

import SwiftUI
import PhotosUI
import SDWebImageSwiftUI

struct PlayerEditView: View {
    @StateObject var viewModel = PlayerViewModel()
    @Environment(\.dismiss)var dismiss
    
    @StateObject var vm = PhotoSelectorViewModel()
    @State private var showPhotoPicker = false
    @State private var saveSuccess = false
    @State private var showAlert = false
    @State private var isConfirming = false
    
    var body: some View {
        VStack {
            Form {
                TextField("Nom", text: $viewModel.name)
                TextField("Numero", text: $viewModel.number)
                    .keyboardType(.numberPad)
                TextField("Post", text: $viewModel.post)
                    .keyboardType(.numberPad)
                TextField("Taille", text: $viewModel.size)
                TextField("Total de point marqué", text: $viewModel.total)
                TextField("Description", text: $viewModel.description)
                VStack {
                    PhotosPicker(
                        selection: $vm.selectedPhotos,
                        maxSelectionCount: 1,
                        selectionBehavior: .ordered,
                        matching: .images
                    ) {
                        Text("Ajouter photo")
                    }
                    if (vm.isSelected) {
                        ForEach(vm.images, id: \.self) { image in
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200)
                        }
                    }
                    if (!viewModel.image.isEmpty) {
                        Text("Photo publiée: ")
                        WebImage(url: URL(string: viewModel.image))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200)
                        Button("Effacer la selection") {
                            Task {
                                try await viewModel.deleteImages()
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            Spacer()
            if case .add = viewModel.formType {
                Button {
                    if (!viewModel.name.isEmpty && !viewModel.number.isEmpty && vm.isSelected){
                        Task {
                            do {
                                for image in vm.images {
                                    await viewModel.uploadImage(image)
                                }
                                try await viewModel.save()
                                viewModel.clear()
                                saveSuccess = true
                            } catch {
                                print("An error occured")
                            }
                        }
                    }
                    else {
                        showAlert = true
                    }
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .frame(width: 250, height: 50)
                            .foregroundStyle(.green)
                        Text("Ajouter le joueur")
                            .foregroundStyle(.white)
                    }
                }
                .alert("Pensez a remplir tous les champs", isPresented: $showAlert) {
                    Button("OK", role: .cancel) { }
                }
                .alert("Joueur ajouté avec succes", isPresented: $saveSuccess) {
                    Button("OK", role: .cancel) { }
                }
            }
            else {
                Button("Delete", role: .destructive) {
                    isConfirming = true
               }
            }
        }
        .confirmationDialog("Supprimer le joueur", isPresented: $isConfirming, titleVisibility: .visible) {
            Button("Annuler", role: .cancel) {}
            Button("Confirmer", role: .destructive) {
                Task {
                    do {
                        try await viewModel.deleteItem()
                        dismiss()
                    } catch {
                        viewModel.error = error.localizedDescription
                    }
                }
            }
        }
        .onChange(of: vm.selectedPhotos) { _, _ in
            vm.convertDataToImage()
        }
        .toolbar {
            if case .edit = viewModel.formType {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Annuler") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Sauvegarder") {
                        Task {
                            do {
                                for image in vm.images {
                                    await viewModel.uploadImage(image)
                                }
                                try await viewModel.save()
                                dismiss()
                            } catch {
                                print("An error occured")
                            }
                        }
                    }
                }
            }
        }
    }
}

struct BookEditView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            return PlayerEditView()
        }
    }
}
