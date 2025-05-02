
import SwiftUI

struct LinerExpandingView: View {
    @Binding var expand: Bool
    let order: Int
    var space: CGFloat = 90
    var symbolName: String
    
    var body: some View {
        ZStack{
            ZStack{
                Image(systemName: symbolName)
                    .font(.system(size: 32, weight: .medium, design: .rounded))
                    .foregroundColor(Color.black).padding()
                    .scaleEffect(expand ? 1 : 0)
//                    .rotationEffect(expand ? .degrees(-45) : .degrees(0))
                    .animation(.easeOut(duration: 0.15), value: expand)
            }
            .frame(width: 82, height: 82)
            .background(Color.green)
            .opacity(expand ? 1 : 0)
            .cornerRadius(expand ? 41 : 8)
            .scaleEffect(expand ? 1 : 0.5)
            .offset(y: expand ? -space*CGFloat(order) : 0)
            .animation(Animation.linear(duration: 0.2).delay(0.01*Double(order)), value: expand)
        }
        
    }
}

#Preview {
    LinerExpandingView(expand: .constant(true),order: 1, space: 50, symbolName: "plus")
}
