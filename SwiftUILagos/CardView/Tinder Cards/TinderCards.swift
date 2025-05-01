//
//  TinderCards.swift
//  SwiftUILagos
//
//  Created by name on 01/05/2025.
//

import SwiftUI

struct TinderCards: View {
    
    // Tells me is the user pressing or dragging or translation the view on the stack
    // only saves the state
    // I think i can move it in the card and pass a state
    enum DragState {
        case inactive
        case pressing
        case dragging(translation: CGSize)
        
        var translation: CGSize {
            switch self {
            case .inactive, .pressing:
                return .zero
            case .dragging(let translation):
                return translation
            }
        }
        
        var isDragging: Bool {
            switch self {
            case .dragging:
                return true
            case .pressing, .inactive:
                return false
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
    }
    
    // make the views on top of each others as array
    // app now only shows two card views in the deck.
    @State private var cardViews: [CardView] = {
        var views = [CardView]()
        
        for index in 0..<2 {
            views.append(CardView(image: trips[index].image, title: trips[index].destination))
        }
        
        return views
    }()
    
    @State private var lastIndex = 1
    @State private var removalTransition = AnyTransition.trailingBottom
    
    @GestureState private var dragState = DragState.inactive
    
    // When reach this limit make the transaction
    // if the card move the right it will = +dragThreshold
    // and if moves to the left = -dragThreshold
    private let dragThreshold: CGFloat = 100.0
    
    var body: some View {
        
        
        VStack {
            TopBarMenu()
            
            // Cards
            ZStack {
                ForEach(cardViews) { cardView in
                    cardView
                        .zIndex(isTopCard(cardView: cardView) ? 1 : 0)
                        .overlay {
                            ZStack {
                                Image(systemName: "x.circle")
                                    .foregroundColor(.white)
                                    .font(.system(size: 100))
                                    .opacity(self.dragState.translation.width < -self.dragThreshold && self.isTopCard(cardView: cardView) ? 1.0 : 0)
                                
                                Image(systemName: "heart.circle")
                                    .foregroundColor(.white)
                                    .font(.system(size: 100))
                                    .opacity(self.dragState.translation.width > self.dragThreshold  && self.isTopCard(cardView: cardView) ? 1.0 : 0.0)
                            }
                        }
                        .offset(x: self.isTopCard(cardView: cardView) ? self.dragState.translation.width : 0,
                                y: self.isTopCard(cardView: cardView) ? self.dragState.translation.height : 0)
                        .scaleEffect(self.dragState.isDragging && self.isTopCard(cardView: cardView) ? 0.95 : 1.0) /// on deagging make the card smaller
                        .rotationEffect(Angle(degrees: self.isTopCard(cardView: cardView) ? Double( self.dragState.translation.width / 10) : 0))
                        .animation(.interpolatingSpring(stiffness: 180, damping: 100), value: self.dragState.translation)
                        .transition(self.removalTransition)
                        .gesture(LongPressGesture(minimumDuration: 0.01)
                            .sequenced(before: DragGesture())
                            .updating(self.$dragState, body: { (value, state, transaction) in
                                switch value {
                                case .first(true):
                                    state = .pressing
                                case .second(true, let drag):
                                    state = .dragging(translation: drag?.translation ?? .zero)
                                default:
                                    break
                                }
                                
                            })
                                .onChanged({ (value) in
                                    guard case .second(true, let drag?) = value else {
                                        return
                                    }
                                    
                                    if drag.translation.width < -self.dragThreshold {
                                        self.removalTransition = .leadingBottom
                                    }
                                    
                                    if drag.translation.width > self.dragThreshold {
                                        self.removalTransition = .trailingBottom
                                    }
                                    
                                })
                                    .onEnded({ (value) in
                                        
                                        guard case .second(true, let drag?) = value else {
                                            return
                                        }
                                        
                                        if drag.translation.width < -self.dragThreshold ||
                                            drag.translation.width > self.dragThreshold {
                                            
                                            self.moveCard()
                                        }
                                    })
                                 
                        )
                }
            }
            
            Spacer(minLength: 20)
            
            BottomBarMenu()
                .opacity(dragState.isDragging ? 0.0 : 1.0)
                .animation(.default, value: dragState.isDragging)
        }
    }
    
    //MARK: - UI Acrions
    
    
    // checks if the card is the last card in the stack of cards
    private func isTopCard(cardView: CardView) -> Bool {
        guard let index = cardViews.firstIndex(where: { $0.id == cardView.id }) else {
            return false
        }
        
        return index == 0
    }
    
    private func moveCard() {
        cardViews.removeFirst()
        
        self.lastIndex += 1
        let trip = trips[lastIndex % trips.count] // with this code the array will not ends
        
        let newCardView = CardView(image: trip.image, title: trip.destination) // add a new card in the last of the array so the cards will be always 2
        
        cardViews.append(newCardView)
    }
    
}

#Preview {
    TinderCards()
}

struct CardView: View, Identifiable {
    
    let id = UUID()
    let image: String
    let title: String
    
    var body: some View {
        Image(image)
            .resizable()
            .scaledToFill()
            .frame(minWidth: 0, maxWidth: .infinity)
            .cornerRadius(10)
            .padding(.horizontal, 15)
            .overlay(alignment: .bottom) {
                VStack {
                    Text(title)
                        .font(.headline)
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                        .background(.white)
                        .cornerRadius(5)
                }
                .padding(.bottom, 20)
            }
    }
}

#Preview {
    CardView(image: "yosemite-usa", title: "Yosemite, USA")
}

//MARK: - TopBarMenu

struct TopBarMenu: View {
    var body: some View {
        HStack {
            Image(systemName: "line.horizontal.3")
                .font(.system(size: 30))
            
            Spacer()
            
            Image(systemName: "mappin.and.ellipse")
                .font(.system(size: 35))
            
            Spacer()
            
            Image(systemName: "heart.circle.fill")
                .font(.system(size: 30))
        } .padding()
    }
}

#Preview {
    TopBarMenu()
}

//MARK: - BottomBarMenu

struct BottomBarMenu: View {
    var body: some View {
        HStack {
            Image(systemName: "xmark")
                .font(.system(size: 30))
                .foregroundColor(.black)
            
            Button {
                // Book the trip
            } label: {
                Text("BOOK IT NOW")
                    .font(.system(.subheadline, design: .rounded))
                    .bold()
                    .foregroundColor(.white)
                    .padding(.horizontal, 35)
                    .padding(.vertical, 15)
                    .background(.black)
                    .cornerRadius(10)
            } .
            padding(.horizontal, 20)
            
            Image(systemName: "heart")
                .font(.system(size: 30))
                .foregroundStyle(.black)
        }
    }
}

#Preview {
    BottomBarMenu()
}

extension AnyTransition {
    static var trailingBottom: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .identity,
            removal: AnyTransition.move(edge: .trailing).combined(with: .move(edge: .bottom))
        )
        
    }
    
    static var leadingBottom: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .identity,
            removal: AnyTransition.move(edge: .leading).combined(with: .move(edge: .bottom))
        )
    }
}
