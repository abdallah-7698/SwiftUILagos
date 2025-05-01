//
//  WalletCardView.swift
//  SwiftUILagos
//
//  Created by name on 01/05/2025.
//

import SwiftUI

struct WalletCardView: View {
    let card: Card
    var body: some View {
        Image(card.type.rawValue)
            .resizable()
            .scaledToFit()
            .overlay(alignment: .bottomLeading) {
                VStack(alignment: .leading) {
                    Text(card.number)
                        .bold()
                    HStack {
                        Text(card.name)
                            .bold()
                        Text("Valid Thru")
                            .font(.footnote)
                        Text(card.expiryDate)
                            .font(.footnote)
                    }
                }
                .foregroundColor(.white)
                .padding(.leading, 25)
                .padding(.bottom, 20)
            }
            .shadow(color: .gray, radius: 1.0, x: 0.0, y: 1.0)
    }
}

#Preview(testCards[0].type.rawValue) { // this code gives a name to the preview based on the card type from the model
    WalletCardView(card: testCards[0])
}
