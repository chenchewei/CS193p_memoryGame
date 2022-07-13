//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Anderson Chen on 2022/6/20.
//

/// View

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    /// Main Container
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                HStack(spacing: 20) {
                    Text("\(viewModel.themeTopic)")
                        .foregroundColor(viewModel.themeColor)
                    Text("Score: \(viewModel.score)")
                        .multilineTextAlignment(.center)
                }
                .font(.title)
                gameBody
                HStack {
                    newGame
                    Spacer()
                    shuffle
                }
                .padding(.horizontal)
            }
            deckBody
        }
    }
    
    // MARK: - Dealing cards
    
    // property wrapper must be var
    /// This is a token which provides a namespace for the id's used in matchGeometryEffect
    @Namespace private var dealingNameSpace
    // Set access to private for temporary track
    /// Whether a card is dealt or not
    @State private var dealt = Set<Int>()
    
    /// Mark the given card had been dealt
    /// - Parameter card: The card that is going to be dealt
    private func deal(_ card: EmojiMemoryGame.Card) {
        dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: EmojiMemoryGame.Card) -> Bool {
        return !dealt.contains(card.id)
    }
    
    /// Custom animation to deal the cards out not all at the same time by adding delay
    /// - Parameter card: card that is going to be dealt
    /// - Returns: custom animation
    private func dealAnimation(for card: EmojiMemoryGame.Card) -> Animation {
        var delay: Double = 0.0
        if let index = viewModel.cards.firstIndex(where: { $0.id == card.id }) {
            delay = Double(index) * (CardConstants.totalDealDuration) / Double(viewModel.cards.count)
        }
        return Animation.easeInOut(duration: CardConstants.dealDuration).delay(delay)
    }
    
    // returns a Double which is a bigger number the closer a card is to the front of the cards array
    // used by both of our matchedGeometryEffect CardViews
    //  so that they order the cards in the "z" direction in the same way
    private func zIndex(of card: EmojiMemoryGame.Card) -> Double {
        return -Double(viewModel.cards.firstIndex(where: { $0.id == card.id }) ?? 0)
    }

    var gameBody: some View {
        AspectVGrid(items: viewModel.cards, aspectRatio: 2/3) { card in
            if isUndealt(card) || card.isMatched && !card.isFaceUp {
                Color.clear
            } else {
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
                    .padding(4)
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
                    .zIndex(zIndex(of: card))
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.75)) {
                            viewModel.choose(card)
                        }
                        
                    }
            }
        }
        .foregroundColor(viewModel.themeColor)
        .padding(.horizontal)
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(viewModel.cards.filter(isUndealt)) { card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
                    .transition(AnyTransition.asymmetric(insertion: .slide, removal: .identity))
                    .zIndex(zIndex(of: card))
            }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
        .foregroundColor(viewModel.themeColor)
        .onTapGesture {
            for card in viewModel.cards {
                withAnimation(dealAnimation(for: card), {
                    deal(card)
                })
            }
        }
    }
    
    var shuffle: some View {
        Button("Shuffle") {
            withAnimation {
                viewModel.shuffle()
            }
        }
    }
    
    var newGame: some View {
        Button {
            dealt = []
            withAnimation {
                viewModel.newGame()
            }
        } label: {
            Text("New Game")
        }
    }
    
    private struct CardConstants {
        static let aspectRatio: CGFloat = 2/3
        static let dealDuration: Double = 0.5
        static let totalDealDuration: Double = 2
        static let undealtHeight: CGFloat = 90
        static let undealtWidth = undealtHeight * aspectRatio
    }
    
}

// MARK: - CardView
struct CardView: View {
    let card: EmojiMemoryGame.Card

    @State private var animatableBonusRemaining: Double = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle(degrees: 0 - 90), endAngle: Angle(degrees: (1 - animatableBonusRemaining) * 360 - 90))
                            .onAppear {
                                animatableBonusRemaining = card.bonusRemaining
                                withAnimation(.linear(duration: card.bonusTimeRemaining)) {
                                    animatableBonusRemaining = 0
                                }
                            }
                    } else {
                        Pie(startAngle: Angle(degrees: 0 - 90), endAngle: Angle(degrees: (1 - card.bonusRemaining) * 360 - 90))
                    }
                }
                    .padding(DrawingConstants.piePadding)
                    .opacity(DrawingConstants.pieOpacity)
                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(Animation.linear(duration: 1.3).repeatForever(autoreverses: false), value: UUID())
                // deprecated
//                    .animation(Animation.linear(duration: 1.3).repeatForever(autoreverses: false))
                    .font(Font.system(size: DrawingConstants.fontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        return min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
    }
    
    private func font(in size: CGSize) -> Font {
        return Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let matchedOpacity: Double = 0
        static let fontScale: CGFloat = 0.75
        static let fontSize: CGFloat = 32
        static let piePadding: CGFloat = 4
        static let pieOpacity: Double = 0.4
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(viewModel: game)
            .preferredColorScheme(.dark)
            .previewInterfaceOrientation(.portrait)
        EmojiMemoryGameView(viewModel: game)
            .preferredColorScheme(.light)
    }
}
