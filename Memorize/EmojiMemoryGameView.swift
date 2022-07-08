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
            Text("Memorize!")
                .font(.system(.largeTitle, design: .rounded))
                .foregroundColor(Color(red: 0.988, green: 0.716, blue: 0.057))
                
            AspectVGrid(items: viewModel.cards, aspectRatio: 2/3) { card in
//                cardView(for: card)
                CardView(card: card)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
            .foregroundColor(.cyan)
            .padding(.horizontal)
            HStack(spacing: 15) {
                ThemeView(title: " Vehicle ", imageName: "car.2")
                    .onTapGesture {
                        viewModel.updateGameType(to: .Vehicle)
                    }
                ThemeView(title: " Nature ", imageName: "globe.asia.australia")
                    .onTapGesture {
                        viewModel.updateGameType(to: .Nature)
                    }
                ThemeView(title: " Food ", imageName: "fork.knife")
                    .onTapGesture {
                        viewModel.updateGameType(to: .Food)
                    }
            }
        }
    }
    
//    @ViewBuilder
//    private func cardView(for card: EmojiMemoryGame.Card) -> some View {
//        if card.isMatched && !card.isFaceUp {
//            Rectangle().opacity(0)
//        } else {
//            CardView(card: card)
//                .padding(4)
//                .onTapGesture {
//                    viewModel.choose(card)
//                }
//        }
//    }
    
}

struct CardView: View {
    let card: EmojiMemoryGame.Card

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.stroke(lineWidth: DrawingConstants.lineWidth)
                    Pie(startAngle: Angle(degrees: -90),
                        endAngle: Angle(degrees: 20))
                        .padding(DrawingConstants.piePadding)
                        .opacity(DrawingConstants.pieOpacity)
                    Text(card.content).font(.largeTitle).padding(4)
                } else if card.isMatched {
                    shape.opacity(DrawingConstants.matchedOpacity)
                } else {
                    shape.fill()
                }
            }
        }
    }
    
    private func font(in size: CGSize) -> Font {
        return Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let matchedOpacity: Double = 0
        static let fontScale: CGFloat = 0.75
        static let piePadding: CGFloat = 4
        static let pieOpacity: Double = 0.4
    }
    
}

struct ThemeView: View {
    
    let title: String
    let imageName: String
    
    var body: some View {
        VStack {
            Image(systemName: imageName)
                .aspectRatio(contentMode: .fit)
            Text(title)
        }
        .foregroundColor(.cyan)
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
