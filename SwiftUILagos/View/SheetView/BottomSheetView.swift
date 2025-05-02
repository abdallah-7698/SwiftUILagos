//
//  BottomSheetView.swift
//  SwiftUILagos
//
//  Created by name on 02/05/2025.
//

import SwiftUI

struct BottomSheetView: View {
    @State var showSheet = false
    
    var body: some View {
        Button ("Show Sheet") {
            showSheet.toggle()
        }
        .sheet(isPresented: $showSheet) {
            SheetView()
                .presentationDetents([.height(200), .height(500)])
                .interactiveDismissDisabled(true) // not dismiss on scrolling down
        }
    }
}

#Preview {
    BottomSheetView()
}

struct SheetView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                Color.red
                    .ignoresSafeArea(.all)
                
                Text("This is \(geometry.size.height)")
                    .foregroundStyle(.black)
                    .padding(.top, 30)
            }
            
        }
        
    }
}
