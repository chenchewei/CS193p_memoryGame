//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Anderson Chen on 2022/7/1.
//

/// ViewModel

import SwiftUI

class EmojiMemoryGame {
    static let emoji = ["🚔","✈️","🚎","🚅","🚜","🚁","🚀","🛴","🎠","🚢","🚛","🛥"]
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numbersOfPairsOfCards: 4) { index in
            emoji[index]
        }
    }
    private var model: MemoryGame<String> = createMemoryGame()
    var cards: Array<MemoryGame<String>.Card> { model.cards }
}
