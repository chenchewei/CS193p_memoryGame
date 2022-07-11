//
//  MemoryGame.swift
//  Memorize
//
//  Created by Anderson Chen on 2022/7/1.
//

/// Model

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var score: Int = 0
    
    init(numbersOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        
        for i in 0..<numbersOfPairsOfCards {
            let content = createCardContent(i)
            cards.append(Card(id: i*2, content: content))
            cards.append(Card(id: i*2+1, content: content))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        let id: Int
        
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var isSeen: Bool = false
        let content: CardContent
    }
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly }
        set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) } }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                } else if cards[chosenIndex].isSeen || cards[potentialMatchIndex].isSeen {
                    score -= 1
                }
                cards[chosenIndex].isFaceUp = true
                cards[chosenIndex].isSeen = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
}
