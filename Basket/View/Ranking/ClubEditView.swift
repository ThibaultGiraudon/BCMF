//
//  RankingEditView.swift
//  Basket
//
//  Created by Thibault Giraudon on 26/08/2023.
//

import SwiftUI
import PhotosUI
import SDWebImageSwiftUI

struct ClubEditView: View {
    @StateObject var viewModel = ClubViewModel()
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
                TextField("Classement", text: $viewModel.rank)
                TextField("Victoire", text: $viewModel.win)
                    .keyboardType(.numberPad)
                TextField("Defaite", text: $viewModel.loose)
                    .keyboardType(.numberPad)
                VStack {
                    if (vm.isSelected) {
                        Image(uiImage: vm.photo)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200)
                    }
                    PhotosPicker(
                        selection: $vm.selectedPhotos,
                        maxSelectionCount: 1,
                        selectionBehavior: .ordered,
                        matching: .images
                    ) {
                        Text("Ajouter photo")
                    }
                }
            }
            Spacer()
            if case .add = viewModel.formType {
                Button {
                    if (!viewModel.name.isEmpty && !viewModel.rank.isEmpty && !viewModel.win.isEmpty && !viewModel.loose.isEmpty){
                        Task {
                            do {
                                await viewModel.uploadImage(vm.photo)
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
                        Text("Ajouter le club")
                            .foregroundStyle(.white)
                    }
                }
                .alert("Pensez a remplir tous les champs", isPresented: $showAlert) {
                    Button("OK", role: .cancel) { }
                }
                .alert("Club ajouté avec succes", isPresented: $saveSuccess) {
                    Button("OK", role: .cancel) { }
                }
            }
            else {
                Button("Delete", role: .destructive) {
                    isConfirming = true
               }
            }
        }
        .confirmationDialog("Supprimer le club", isPresented: $isConfirming, titleVisibility: .visible) {
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
                                await viewModel.uploadImage(vm.photo)
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

struct ClubEditView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ClubEditView()
        }
    }
}
