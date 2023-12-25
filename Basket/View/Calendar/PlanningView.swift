//
//  PlanningView.swift
//  Basket
//
//  Created by Thibault Giraudon on 28/02/2023.
//

import SwiftUI

struct PlanningView: View {
    @ObservedObject private var viewModel = PlanningsViewModel()
    @ObservedObject var gs = GlobalState.shared
    @State var presentAddPlanningSheet = false
    @State var presentLoginSheet = false
    
    var body: some View {
        VStack {
            PlanningTitleView()
            Divider()
            ForEach(viewModel.plannings) { planning in
//                if gs.isAuthenticated {
                    NavigationLink(destination : PlanningEditView(viewModel: PlanningViewModel(planning: planning), mode: .edit)) {
                        PlanningRowView(planning: planning)
                    }
                    .foregroundColor(.black)
//                }
//                else {
//                    PlanningRowView(planning: planning)
//                }
                Divider()
            }
        }
        .navigationTitle("Planning")
        .sheet(isPresented: $gs.presentAddSheet) {
            NavigationView {
                PlanningEditView()
            }
        }
        .onAppear() {
            self.viewModel.subscribe()
        }
        .preferredColorScheme(gs.isDarkMode == true ? .dark : .light)
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PlanningView()
        }
    }
}
