//
//  HorizontalScroll3D.swift
//  SwiftUILagos
//
//  Created by name on 02/05/2025.
//

import SwiftUI

struct HorizontalScroll3D: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                    GeometryReader { geometry in
                        RoundedRectangle(cornerRadius: 30)
                            .fill(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)), Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .rotation3DEffect(
                                Angle(
                                    degrees: Double((geometry.frame(in: .global).minX - 20) / -20)
                                ),
                                axis: (x: 0, y: 1, z: 0),
                                anchor: .center,
                                anchorZ: 0.0,
                                perspective: 1.0)
                    }
                    .frame(width: 300, height: 300)
                }
            }
            .padding(.horizontal)
            .padding(.trailing, 20)
        }
        
    }
}

#Preview {
    HorizontalScroll3D()
}
