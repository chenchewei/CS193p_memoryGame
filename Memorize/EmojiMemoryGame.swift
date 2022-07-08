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
    
    enum GameType {
        case Food
        case Nature
        case Vehicle
    }
    
    private static var gameType: GameType = .Vehicle
    
    private static let vehicles = ["🚔","✈️","🚎","🚅","🚜","🚁","🚀","🛴","🎠","🚢","🚛","🛥","🛩","🚖","🛰","🛸","🛶","🚇","🚤","⛴"]
    private static let nature = ["🐳","🐸","🐔","🦉","🐵","🦆","🦐","🦑","🐍","🦧"]
    private static let food = ["🍎","🍐","🍊","🍋","🍌","🍉","🍇","🍓","🫐","🍈","🍒","🥭","🍆","🍔","🥩","🥐","🍞","🥯","🧆","🍙","🍦","🍫","🥜","🍪","🍿","🍩","🍭","🍡","🥟","🍱"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numbersOfPairsOfCards: 10) { index in
            switch gameType {
            case .Food:
                return food[index]
            case .Nature:
                return nature[index]
            case .Vehicle:
                return vehicles[index]
            }
        }
    }
    
    // Every time this parameter changes, it will call objectWillChange.send()
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: Array<Card> { model.cards }
    
    
    // MARK: - Intent(s)
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func updateGameType(to type: GameType) {
        guard EmojiMemoryGame.gameType != type else { return }
        EmojiMemoryGame.gameType = type
        model = EmojiMemoryGame.createMemoryGame()
    }
}
