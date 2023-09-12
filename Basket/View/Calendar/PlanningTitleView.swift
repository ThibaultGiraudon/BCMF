//
//  CalendarTitle.swift
//  Basket
//
//  Created by Thibault Giraudon on 03/03/2023.
//

import SwiftUI

struct PlanningTitleView: View {
    var body: some View {
        HStack{
            Text("Date")
                .frame(width: UIScreen.main.bounds.width * (0.07))
            Text("Heure")
                .frame(width: UIScreen.main.bounds.width * (0.07))
            Text("Domicile")
                .frame(width: UIScreen.main.bounds.width * (0.34))
            Text("Visiteur")
                .frame(width: UIScreen.main.bounds.width * (0.34))
            Text("Resultat")
                .frame(width: UIScreen.main.bounds.width * (0.09))
        }
        .font(.system(size: 7))
        .multilineTextAlignment(.leading)
    }
}

struct CalendarTitle_Previews: PreviewProvider {
    static var previews: some View {
        PlanningTitleView()
    }
}
