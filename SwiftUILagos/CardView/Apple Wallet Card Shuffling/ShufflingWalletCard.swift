//
//  ShufflingWalletCard.swift
//  SwiftUILagos
//
//  Created by name on 01/05/2025.
//
import SwiftUI

struct ShufflingWalletCard: View {
    
    enum DragState {
        case inactive
        case pressing(index: Int? = nil)
        case dragging(index: Int? = nil, translation: CGSize)
        
        var index: Int? {
            switch self {
            case .pressing(let index), .dragging(let index, _):
                return index
            case .inactive:
                return nil
            }
        }
        
        var translation: CGSize {
            switch self {
            case .inactive, .pressing:
                return .zero
            case .dragging(_, let translation):
                return translation
            }
        }
        
        var isPressing: Bool {
            switch self {
            case .pressing, .dragging:
                return true
            case .inactive:
                return false
            }
        }
        
        var isDragging: Bool {
            switch self {
            case .dragging:
                return true
            case .inactive, .pressing:
                return false
            }
        }
    }
    
    @State var cards: [Card] = testCards
    
    private let cardHeight: CGFloat = 220
    private let cardOffset: CGFloat = 30.0
    
    @State private var isAppears: Bool = false
    
    @GestureState private var dragState = DragState.inactive
    
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 150)
            ZStack {
                ForEach(0..<Array(cards).count, id: \.self) { index in
                    let card = cards[index]
                    WalletCardView(card: card)
                        .frame(height: cardHeight)
                        .padding(.horizontal, 35)
                        .offset(y: setOffset(index: index))
                        .zIndex(setZIndex(index: index))
                        .gesture (
                            TapGesture()
                                .onEnded { _ in
                                    withAnimation {
                                        isAppears.toggle()
                                        if !isAppears {
                                            makeItemFirst(index: index)
                                        }
                                    }
                                }
                                .exclusively(before: LongPressGesture(minimumDuration: 0.05)
                                    .sequenced(before: DragGesture())
                                    .updating(self.$dragState, body: { (value, state, transaction) in
                                        switch value {
                                        case .first(true):
                                            state = .pressing(index: index)
                                        case .second(true, let drag):
                                            state = .dragging(index: index, translation: drag?
                                                .translation ?? .zero)
                                        default:
                                            break
                                        }
                                    })
                                        .onEnded({ (value) in
                                            guard case .second(true, let drag?) = value else {
                                                return
                                            }
                                            
                                            self.rearrangeCards(index: index, dragOffset: drag.translation)
                                        })
                                )
                        )
                    
                }
            }
            
            Spacer()
        }
        
    }
    
    func setZIndex(index: Int) -> Double {
        // The default z-index of a card is set to a negative value of the card's index,
        // so that the first card will have the largest z-index.
        let defaultZIndex = -Double(index)
        // If it's the dragging card
        if let draggingIndex = dragState.index,
           index == draggingIndex {
            // we compute the new z-index based on the translation's height
            return defaultZIndex + Double(dragState.translation.height/cardOffset)
        }
        // Otherwise, we return the default z-index
        return defaultZIndex
    }
    
    func setOffset(index: Int) -> CGFloat {
        if isAppears {
            return cardHeight*CGFloat(index)
        }
        
        var pressedOffset = CGSize.zero
        var dragOffsetY: CGFloat = 0.0
        
        if let draggingIndex = dragState.index, index == draggingIndex {
            pressedOffset.height = dragState.isPressing ? -20 : 0
            dragOffsetY = dragState.translation.height
        }
        
        return -cardOffset*CGFloat(index) + pressedOffset.height + dragOffsetY
    }
    
    private func makeItemFirst(index: Int) {
        cards = Array(cards[index...] + cards[..<index])
    }
    
    private func rearrangeCards(index: Int, dragOffset: CGSize) {
        var newIndex = index + Int(-dragOffset.height / cardOffset)
        newIndex = newIndex >= cards.count ? cards.count - 1 : newIndex
        newIndex = newIndex < 0 ? 0 : newIndex
        let removedCard = cards.remove(at: index)
        cards.insert(removedCard, at: newIndex)
    }
    
}

#Preview {
    ShufflingWalletCard()
}

