//
//  MenuView.swift
//  Basket
//
//  Created by Thibault Giraudon on 02/03/2023.
//

import SwiftUI

struct MenuView: View {
    @Namespace private var menuItemTransition
    @State var selectedIndex = 0
    var menuItems = [ "Equipe", "Classement", "Calendrier" ]
 
    var body: some View {
        HStack {
            Spacer()
 
            ForEach(menuItems.indices) { index in
 
                if index == selectedIndex {
                    Text(menuItems[index])
                        .padding(.horizontal)
                        .padding(.vertical, 4)
                        .background(Capsule().foregroundColor(Color(uiColor: .green)))
                        .foregroundColor(.white)
                        .matchedGeometryEffect(id: "menuItem", in: menuItemTransition)
                } else {
                    Text(menuItems[index])
                        .padding(.horizontal)
                        .padding(.vertical, 4)
                        .background(Capsule().foregroundColor(Color(uiColor: .systemGray5)))
                        .onTapGesture {
                            selectedIndex = index
                        }
                }
 
                Spacer()
            }
 
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
        .animation(.easeInOut, value: selectedIndex)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
