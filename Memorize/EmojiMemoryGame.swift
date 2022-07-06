//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Anderson Chen on 2022/7/1.
//

/// ViewModel

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    static let emoji = ["🚔","✈️","🚎","🚅","🚜","🚁","🚀","🛴","🎠","🚢","🚛","🛥"]
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numbersOfPairsOfCards: 4) { index in
            emoji[index]
        }
    }
    
    // Every time this parameter changes, it will call objectWillChange.send()
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> { model.cards }
    
    
    // MARK: - Intent(s)
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
