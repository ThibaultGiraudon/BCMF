//
//  PlanningView.swift
//  Basket
//
//  Created by Thibault Giraudon on 28/02/2023.
//

import SwiftUI

struct PlanningView: View {
    @ObservedObject private var viewModel = PlanningsViewModel()
    @State var presentAddPlanningSheet = false
    @State var presentLoginSheet = false
    @ObservedObject var gs = GlobalState.shared
    
    var body: some View {
        VStack {
            PlanningTitleView()
            Divider()
            ForEach(viewModel.plannings) { planning in
                if gs.isAuthenticated {
                    NavigationLink(destination : PlanningEditView(viewModel: PlanningViewModel(planning: planning), mode: .edit)) {
                        PlanningRowView(planning: planning)
                    }
                    .foregroundColor(.black)
                }
                else {
                    PlanningRowView(planning: planning)
                }
                Divider()
            }
        }
        .navigationTitle("Planning")
        .navigationBarItems(leading: LoginButton() {
            self.presentLoginSheet.toggle()
        })
        .sheet(isPresented: self.$presentLoginSheet) {
            LoginView()
        }
        .navigationBarItems(trailing: AddButton() {
            self.presentAddPlanningSheet.toggle()
        })
        .sheet(isPresented: self.$presentAddPlanningSheet) {
            NavigationView {
                PlanningEditView()
            }
        }
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
