//
//  CalendarRowView.swift
//  Basket
//
//  Created by Thibault Giraudon on 26/08/2023.
//

import SwiftUI

struct PlanningRowView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var planning: Planning
    
    var body: some View {
        HStack {
            Text(dateFormatter.string(from: planning.date))
                .frame(width: UIScreen.main.bounds.width * 0.07)
            Text(timeFormatter.string(from: planning.hour))
                .frame(width: UIScreen.main.bounds.width * 0.07)
            Text(planning.team1)
                .frame(width: UIScreen.main.bounds.width * 0.34)
            Text(planning.team2)
                .frame(width: UIScreen.main.bounds.width * 0.34)
            Text(planning.result)
                .frame(width: UIScreen.main.bounds.width * 0.09)
        }
        .font(.system(size: 7))
        .multilineTextAlignment(.leading)
        .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
    }
}

struct CalendarRowView_Previews: PreviewProvider {
    static var previews: some View {
        let planning = Planning(
            date: Date(), // Replace with your actual date value
            hour: Date(), // Replace with your actual date value
            team1: "MONTBRISON FEMININE BC - 2",
            team2: "IE FRAISSE-UNIEUX BASKET 42 - 2",
            result: "03-03",
            image1: "https://firebasestorage.googleapis.com/v0/b/bcmf-d3d8a.appspot.com/o/bcmf%402x.jpg?alt=media&token=2bf8f095-5f3b-4d33-a4e8-2ef67583e190",
            image2: "",
            sort: 11
        )
        return PlanningRowView(planning: planning)
    }
}

// Date Formatters
fileprivate var dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd/MM"
    return formatter
}()

fileprivate var timeFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"
    return formatter
}()

