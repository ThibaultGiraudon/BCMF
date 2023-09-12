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
        HStack{
            Text(planning.date)
                .frame(width: UIScreen.main.bounds.width * (0.07))
            Text(planning.hour)
                .frame(width: UIScreen.main.bounds.width * (0.07))
            Text(planning.team1)
                .frame(width: UIScreen.main.bounds.width * (0.34))
            Text(planning.team2)
                .frame(width: UIScreen.main.bounds.width * (0.34))
            Text(planning.result)
                .frame(width: UIScreen.main.bounds.width * (0.09))
        }
        .font(.system(size: 7))
        .multilineTextAlignment(.leading)
        .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
    }
}

struct CalendarRowView_Previews: PreviewProvider {
    static var previews: some View {
        let planning = Planning(date: "03/03", hour: "03:03", team1: "MONTBRISON FEMININE BC - 2", team2: "IE FRAISSE-UNIEUX BASKET 42 - 2", result: "03-03", sort: 11)
        PlanningRowView(planning: planning)
    }
}
