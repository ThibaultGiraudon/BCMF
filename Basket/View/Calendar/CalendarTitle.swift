//
//  CalendarTitle.swift
//  Basket
//
//  Created by Thibault Giraudon on 03/03/2023.
//

import SwiftUI

struct CalendarTitle: View {
    var body: some View {
        HStack{
            Text("Date")
                .frame(width: UIScreen.main.bounds.height * (0.04))
                .font(.system(size: 7))
            Text("Heure")
                .frame(width: UIScreen.main.bounds.height * (0.04))
                .font(.system(size: 7))
            Text("Domicile")
                .frame(width: UIScreen.main.bounds.height * (0.15))
                .font(.system(size: 7))
            Text("Visiteur")
                .frame(width: UIScreen.main.bounds.height * (0.15))
                .font(.system(size: 7))
            Text("Resultat")
                .frame(width: UIScreen.main.bounds.height * (0.05))
                .font(.system(size: 7))
        }
    }
}

struct CalendarTitle_Previews: PreviewProvider {
    static var previews: some View {
        CalendarTitle()
    }
}
