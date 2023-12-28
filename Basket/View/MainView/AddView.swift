//
//  AddView.swift
//  Basket
//
//  Created by Thibault Giraudon on 28/12/2023.
//

import SwiftUI

struct AddView: View {
    var body: some View {
        List {
            NavigationLink("Ajouter un evenement", destination: EventEditView())
            NavigationLink("Ajouter un club", destination: ClubEditView())
        }
    }
}

#Preview {
    NavigationStack {
        AddView()
    }
}
