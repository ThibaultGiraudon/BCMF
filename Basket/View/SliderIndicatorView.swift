//
//  SliderIndicatorView.swift
//  CloneAirBnb
//
//  Created by Thibault Giraudon on 02/11/2023.
//

import SwiftUI

struct SliderIndicatorView: View {
    let pageIndex: Int
    let pageCount: Int
    var body: some View {
        HStack{
            ForEach(0..<pageCount, id: \.self) {index in
                Capsule()
                    .fill(pageIndex == index ? .green : .gray.opacity(0.2))
                    .frame(width: 8, height: 8)
                    .animation(.easeInOut, value: pageIndex)
                    .background(
                        .regularMaterial,
                        in: Circle()
                    )
            }
        }
        .padding(.bottom)
    }
}

#Preview {
    SliderIndicatorView(pageIndex: 0, pageCount: 3)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.gray)
}
