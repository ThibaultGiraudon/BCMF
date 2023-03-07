//
//  CalendarView.swift
//  Basket
//
//  Created by Thibault Giraudon on 28/02/2023.
//

import SwiftUI
import EventKit

struct CalendarView: View {
    @ObservedObject private var viewModel = ViewModel()
    var body: some View {
        VStack {
            CalendarTitle()
            Divider()
            ForEach(viewModel.plannings) { planning in
                HStack{
                    Text(planning.date)
                        .multilineTextAlignment(.leading)
                        .frame(width: UIScreen.main.bounds.height * (0.04))
                        .font(.system(size: 7))
                    Text(planning.hour)
                        .multilineTextAlignment(.leading)
                        .frame(width: UIScreen.main.bounds.height * (0.04))
                        .font(.system(size: 7))
                    Text(planning.team1)
                        .multilineTextAlignment(.leading)
                        .frame(width: UIScreen.main.bounds.height * (0.15))
                        .font(.system(size: 7))
                    Text(planning.team2)
                        .multilineTextAlignment(.leading)
                        .frame(width: UIScreen.main.bounds.height * (0.15))
                        .font(.system(size: 7))
                    Text(planning.result)

                        .multilineTextAlignment(.leading)
                        .frame(width: UIScreen.main.bounds.height * (0.05))
                        .font(.system(size: 7))
                }
                Divider()
            }

        }
        .onAppear() {
            self.viewModel.fetchData()
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
