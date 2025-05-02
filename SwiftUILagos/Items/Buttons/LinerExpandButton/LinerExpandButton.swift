//
//  LinerExpandButton.swift
//  SwiftUILagos
//
//  Created by name on 02/05/2025.
//

import SwiftUI

struct LinerExpandButton: View {
    @State var isAnimating: Bool = false

    var body: some View {
        ZStack(alignment: .bottom){
            Color.white.edgesIgnoringSafeArea(.all)
            ZStack{
                LinerExpandingView(expand: $isAnimating,order: 1, symbolName: "phone.fill")
                LinerExpandingView(expand: $isAnimating,order: 2, symbolName: "message")
                LinerExpandingView(expand: $isAnimating,order: 3, symbolName: "house.fill")
                LinerExpandingView(expand: $isAnimating,order: 4, symbolName: "mic.fill")
                
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 50, weight: isAnimating ? .regular : .semibold))
                    .foregroundColor(isAnimating ? Color.red : Color.green)
                    .rotationEffect(isAnimating ? .degrees(45) : .degrees(0))
//                    .opacity(isAnimating ? 0.25 : 1)
                    .animation(Animation.spring(response: 0.35, dampingFraction: 0.85, blendDuration: 1), value: isAnimating)
                    .onTapGesture {
                        isAnimating.toggle()
                    }
            }
        }
    }
}

#Preview {
    LinerExpandButton()
}
