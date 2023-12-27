//
//  PlanningView.swift
//  Basket
//
//  Created by Thibault Giraudon on 28/02/2023.
//

import SwiftUI

struct PlanningView: View {
    @ObservedObject private var viewModel = PlanningsViewModel()
    
    var body: some View {
        VStack {
            PlanningTitleView()
            Divider()
            ForEach(viewModel.plannings) { planning in
                NavigationLink(destination : PlanningEditView(viewModel: PlanningViewModel(planning: planning), mode: .edit)) {
                    PlanningRowView(planning: planning)
                }
                .foregroundColor(.black)
                Divider()
            }
        }
        .navigationTitle("Planning")
        .onAppear() {
            self.viewModel.subscribe()
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PlanningView()
        }
    }
}
