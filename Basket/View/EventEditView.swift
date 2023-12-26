//
//  EventEditView.swift
//  Basket
//
//  Created by Thibault Giraudon on 23/12/2023.
//

import SwiftUI
import SDWebImageSwiftUI
import PhotosUI

class PhotoSelectorViewModel: ObservableObject {
    @Published var photo = UIImage()
    @Published var selectedPhotos = [PhotosPickerItem]()
    @Published var isSelected = false
    
    @MainActor
    func convertDataToImage() {
        isSelected = false
        if !selectedPhotos.isEmpty {
            for eachItem in selectedPhotos {
                Task {
                    if let imageData = try? await eachItem.loadTransferable(type: Data.self) {
                        if let image = UIImage(data: imageData) {
                            photo = image
                            isSelected = true
                        }
                    }
                }
            }
        }
        
        selectedPhotos.removeAll()
    }
}

struct EventEditView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel = EventViewModel()
    @StateObject var vm = PhotoSelectorViewModel()
    @State private var isUploaded = false
    @State private var showAlertImage = false
    @State private var showAlert = false
    @State private var showPhotoPicker1 = false
    @State private var showPhotoPicker2 = false
    @State private var uploadSuccess = false
    @State private var saveSuccess = false
    @State private var selectedImage: URL?
    let maxPhotosToSelect = 1
    private var types = ["match", "autre"]
    var mode: Mode = .new
    
    var body: some View {
        VStack {
            Form {
            Picker("Type", selection: $viewModel.type) {
                ForEach(types, id: \.self) { type in
                    Text(type)
                }
            }
            .pickerStyle(.inline)
            TextField("Titre", text: $viewModel.title)
            TextField("Description", text: $viewModel.description)
            DatePicker("Date", selection: $viewModel.date, displayedComponents: [.date])
            DatePicker("Heure", selection: $viewModel.date, displayedComponents: [.hourAndMinute])
            if viewModel.type == "match" {
                VStack(alignment: .leading) {
                    TextField("Equipe 1", text: $viewModel.team1_name)
                    if !viewModel.team1_image.isEmpty {
                        WebImage(url: URL(string: viewModel.team1_image))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipped()
                            .cornerRadius(8)
                    }
                    Button{
                        showPhotoPicker1.toggle()
                    } label: {
                        Text("Logo equipe 1")
                    }
                    .sheet(isPresented: $showPhotoPicker1, content: {
                        NavigationStack {
                            FirebasePhotoPicker(selectedImage: $viewModel.team1_image)
                                .navigationBarItems (
                                    leading:
                                        Button(action: { showPhotoPicker1.toggle() }) {
                                            Text("Cancel")
                                        }
                                )
                        }
                    })
                }
                VStack(alignment: .leading) {
                    TextField("Equipe 2", text: $viewModel.team2_name)
                    if !viewModel.team2_image.isEmpty {
                        WebImage(url: URL(string: viewModel.team2_image))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipped()
                            .cornerRadius(8)
                    }
                    Button{
                        showPhotoPicker2.toggle()
                    } label: {
                        Text("Logo equipe 2")
                    }
                    .sheet(isPresented: $showPhotoPicker2, content: {
                        NavigationStack {
                            FirebasePhotoPicker(selectedImage: $viewModel.team2_image)
                                .navigationBarItems (
                                    leading:
                                        Button(action: { showPhotoPicker2.toggle() }) {
                                            Text("Cancel")
                                        }
                                )
                        }
                    })
                }
            }
            else {
                VStack {
                    if (vm.isSelected) {
                        Image(uiImage: vm.photo)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200)
                    }
                    PhotosPicker(
                        selection: $vm.selectedPhotos,
                        maxSelectionCount: maxPhotosToSelect,
                        selectionBehavior: .ordered,
                        matching: .images
                    ) {
                        Text("Ajouter photo")
                    }
                }
            }
        }
            Spacer()
            if viewModel.type == "autre" {
                Button {
                    if vm.isSelected == true {
                        isUploaded = true
                        Task { await viewModel.uploadImage(vm.photo) }
                        uploadSuccess = true
                    }
                    else {
                        showAlertImage = true
                    }
                } label: {
                    Text("Televerser l'image")
                        .foregroundStyle(.green)
                }
                .alert("Vous n'avez pas selectionne d'image", isPresented: $showAlertImage) {
                    Button("OK", role: .cancel) { }
                }
                .alert("Image televersee avec succes", isPresented: $uploadSuccess) {
                    Button("OK", role: .cancel) { }
                }
            }
            Button {
                if (((viewModel.type == "autre" && isUploaded == true ||
                     (viewModel.type == "match" && !viewModel.team1_image.isEmpty && !viewModel.team2_image.isEmpty)) && !viewModel.title.isEmpty && !viewModel.type.isEmpty && !viewModel.description.isEmpty)){
                    do {
                        try viewModel.save()
                        viewModel.clear()
                    } catch {}
                    saveSuccess = true
                }
                else {
                    showAlert = true
                }
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .frame(width: 250, height: 50)
                        .foregroundStyle(.green)
                    Text("Ajouter l'evenement")
                        .foregroundStyle(.white)
                }
            }
            .alert(viewModel.type == "match" ? "Pensez a remplir tous les champs" : "Pensez a televerser l'image et a remplir tous les champs", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            }
            .alert("Evenement ajoute avec succes", isPresented: $saveSuccess) {
                Button("OK", role: .cancel) { }
            }
        }
        .onChange(of: vm.selectedPhotos) { _, _ in
            vm.convertDataToImage()
        }
    }
}

#Preview {
    NavigationStack {
        EventEditView()
    }
}
