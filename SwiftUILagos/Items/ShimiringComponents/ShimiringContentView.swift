//
//  ShimiringContentView.swift
//  SwiftUILagos
//
//  Created by name on 02/05/2025.
//

import SwiftUI

struct ShimiringContentView: View {
    @State var isLoading = true
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            ShimiringContentViewCardView()
                .redacted(reason: isLoading ? .placeholder : .init()) // this modifire make the shimiring to all the views in the card 
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        isLoading = false
                    }
                }
        }
    }
}

#Preview {
    ShimiringContentView()
}

struct ShimiringContentViewCardView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Image(uiImage: #imageLiteral(resourceName: "avatar"))
                .resizable().aspectRatio(contentMode: .fit)
                .mask(Circle())
                .frame(width: 44, height: 44)
            Text("Designing fluid interfaces")
                .font(.title2).bold()
            Text("By Chan Karunamuni".uppercased())
                .font(.footnote).bold()
                .foregroundColor(.secondary)
            Text("Discover the techniques used to create the fluid gestural interface of iPhone X. Learn how to design with gestures and motion that feel intuitive and natural, making your app a delight to use.")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.secondary)
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 300)
        .background(Color.white)
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 40)
        .padding()
    }
}
