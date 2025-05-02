//
//  BlurDemoView.swift
//  SwiftUILagos
//
//  Created by name on 02/05/2025.
//

import SwiftUI

//MARK: - With Apple Blure Class VisualEffectBlur

struct BlurDemoView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.blue)
                .padding()
            Text("Hello, World!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .frame(height: 600, alignment: .top)
                .padding(.top)
            VisualEffectBlur(blurStyle: .systemMaterial)
                .ignoresSafeArea()
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .frame(width: 300, height: 400)
                .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
        }
    }
    
   
    
}

#Preview {
    BlurDemoView()
//        .preferredColorScheme(.dark)
}

extension View {
    func backgroundBlur(radius: CGFloat = 3, opaque: Bool = false) -> some View {
        self.background(
            Blur(radius: radius,
                 opaque: opaque)
        )
    }
}

// MARK: - Or use the extension and set the blure degree you want

struct Blur2DemoView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.blue)
                .padding()
            Text("Hello, World!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .frame(height: 600, alignment: .top)
                .padding(.top)
        }
        .overlay{
            Rectangle()
                .fill(Color(.systemBackground))
                .opacity(0.2)
                .backgroundBlur(radius: 10, opaque: true)
        }
        
    }
}

#Preview {
    Blur2DemoView()
//        .preferredColorScheme(.dark)
}
