//
//  CalendarRow.swift
//  Basket
//
//  Created by Thibault Giraudon on 03/03/2023.
//

import SwiftUI

struct CalendarRow: View {
    var date: Date
    var body: some View {
        HStack{
            Text(date.date)
                .multilineTextAlignment(.leading)
                .frame(width: UIScreen.main.bounds.height * (0.04))
                .font(.system(size: 7))
            Text(date.hour)
                .multilineTextAlignment(.leading)
                .frame(width: UIScreen.main.bounds.height * (0.04))
                .font(.system(size: 7))
            Text(date.team1)
                .multilineTextAlignment(.leading)
                .frame(width: UIScreen.main.bounds.height * (0.15))
                .font(.system(size: 7))
            Text(date.team2)
                .multilineTextAlignment(.leading)
                .frame(width: UIScreen.main.bounds.height * (0.15))
                .font(.system(size: 7))
            Text(date.result)
    
                .multilineTextAlignment(.leading)
                .frame(width: UIScreen.main.bounds.height * (0.05))
                .font(.system(size: 7))
        }
    }
}

struct CalendarRow_Previews: PreviewProvider {
    static var previews: some View {
        CalendarRow(date: date[1])
    }
}
