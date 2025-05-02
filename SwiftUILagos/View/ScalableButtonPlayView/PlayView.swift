//
//  PlayView.swift
//  SwiftUILagos
//
//  Created by name on 02/05/2025.
//

import SwiftUI

struct PlayView: View {
    
    var namespace: Namespace.ID
    
    var body: some View {
        VStack(spacing: 20) {
            RoundedRectangle(cornerRadius: 30)
                .matchedGeometryEffect(id: "cover", in: namespace)
                .frame(height: 300)
                .padding()
            Text("Fever")
                .matchedGeometryEffect(id: "title", in: namespace)
            HStack {
                Image(systemName: "play.fill")
                    .matchedGeometryEffect(id: "play", in: namespace)
                    .font(.title)
                Image(systemName: "forward.fill")
                    .matchedGeometryEffect(id: "forward", in: namespace)
                    .font(.title)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)))
                .matchedGeometryEffect(id: "background", in: namespace)
        )
        .ignoresSafeArea()
    }
}

#Preview {
    @Previewable @Namespace var namespace
    PlayView(namespace: namespace)
}
