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

    var body: some View {
        VStack {
            Text("\(viewModel.themeTopic)")
                .font(.largeTitle)
                .foregroundColor(viewModel.themeColor)
                
            AspectVGrid(items: viewModel.cards, aspectRatio: 2/3) { card in
                if card.isMatched && !card.isFaceUp {
                    Rectangle().opacity(0)
                } else {
                    CardView(card: card)
                        .padding(4)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
            .foregroundColor(viewModel.themeColor)
            .padding(.horizontal)
            HStack(spacing: 45) {
                Text("Score: \(viewModel.score)")
                Button {
                    viewModel.newGame()
                } label: {
                    Text("New Game")
                }

            }
            .font(.title)
        }
    }
    
}

struct CardView: View {
    let card: EmojiMemoryGame.Card

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Pie(startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 20))
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
