//
//  MemoryGame.swift
//  Memorize
//
//  Created by Anderson Chen on 2022/7/1.
//

/// Model

import Foundation

struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    func choose(_ card: Card) {
        
    }
    
    init(numbersOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        
        for i in 0..<numbersOfPairsOfCards {
            let content = createCardContent(i)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    struct Card {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
    }
}


