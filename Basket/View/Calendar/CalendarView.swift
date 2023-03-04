//
//  CalendarView.swift
//  Basket
//
//  Created by Thibault Giraudon on 28/02/2023.
//

import SwiftUI
import EventKit

struct CalendarView: View {
    
    var body: some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            VStack {
                CalendarTitle()
                Divider()
                ForEach(date) { date in
                    CalendarRow(date: date)
                    Divider()
                }
            }
        }
        else {
            Table(date) {
                TableColumn("Date", value: \.date)
                    .width(UIScreen.main.bounds.height * (0.1))
                TableColumn("Heure", value: \.hour)
                    .width(UIScreen.main.bounds.height * (0.05))
                TableColumn("Domicile", value: \.team1)
                TableColumn("Visiteur", value: \.team2)
                TableColumn("Resultat", value: \.result)
                    .width(UIScreen.main.bounds.height * (0.07))
            }
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
