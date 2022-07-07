//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Anderson Chen on 2022/7/1.
//

/// ViewModel

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    // 在這個頁面裡不必每次都宣告型別全稱
    typealias Card = MemoryGame<String>.Card
    
    private static let emoji = ["🚔","✈️","🚎","🚅","🚜","🚁","🚀","🛴","🎠","🚢","🚛","🛥"]
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numbersOfPairsOfCards: 4) { index in
            emoji[index]
        }
    }
    
    // Every time this parameter changes, it will call objectWillChange.send()
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: Array<Card> { model.cards }
    
    
    // MARK: - Intent(s)
    func choose(_ card: Card) {
        model.choose(card)
    }
}
