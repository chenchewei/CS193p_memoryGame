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
    // Every time this parameter changes, it will call objectWillChange.send()
    @Published private var model: MemoryGame<String>
    private var theme: Theme
    var themeTopic: String { theme.topic }
    var cards: Array<Card> { model.cards }
    var score: Int { model.score }
    
    private static let themes: Array<Theme> = [
        Theme(topic: "Vehicle",
              content: ["🚔","✈️","🚎","🚅","🚜","🚁","🚀","🛴","🎠","🚢","🚛","🛥","🛩","🚖","🛰","🛸","🛶","🚇","🚤","⛴"],
              numberOfPairsOfCards: 10,
              themeColor: "cyan"),
        Theme(topic: "Nature",
              content: ["🐳","🐸","🐔","🦉","🐵","🦆","🦐","🦑","🐍","🦧"],
              numberOfPairsOfCards: 12,
              themeColor: "green"),
        Theme(topic: "Food",
              content: ["🍎","🍐","🍊","🍋","🍌","🍉","🍇","🍓","🫐","🍈","🍒","🥭","🍆","🍔","🥩","🥐","🍞","🥯","🧆","🍙","🍦","🍫","🥜","🍪","🍿","🍩","🍭","🍡","🥟","🍱"],
              numberOfPairsOfCards: 15,
              themeColor: "red"),
        Theme(topic: "Activity",
              content: ["⚽️","🏀","🏈","⚾️","🥎","🎾","🏐","🏉","🥏","🎱","🪀","🏓","🏸","🏒","🏑","🥍","🏏","🪃","🥊","🤿","🏹","🪁","🪂","🏋️‍♀️"],
              numberOfPairsOfCards: 9,
              themeColor: "yellow"),
        Theme(topic: "Object",
              content: ["⌚️","📱","🖨","💻","🧭","💡","🧯","💿","🎙","💳"],
              numberOfPairsOfCards: 12,
              themeColor: "gray"),
        Theme(topic: "Flag",
              content: ["🇨🇦","🏴‍☠️","🏳️‍🌈","🇦🇽","🇦🇮","🇦🇺","🇧🇷","🇹🇩","🇩🇰","🇨🇮","🇩🇪","🇪🇺","🇯🇵","🇱🇷","🇹🇼","🇬🇧","🇨🇨","🇱🇧","🇳🇮","🇫🇲","🇲🇨","🇵🇸","🇻🇳","🏴󠁧󠁢󠁥󠁮󠁧󠁿"],
              numberOfPairsOfCards: 17,
              themeColor: "orange")
    ]
    
    var themeColor: Color {
        switch theme.themeColor {
        case "cyan":
            return .cyan
        case "green":
            return .green
        case "red":
            return .red
        case "yellow":
            return .yellow
        case "gray":
            return .gray
        case "orange":
            return .orange
        default:
            return .brown
        }
    }
    
    init() {
        theme = EmojiMemoryGame.themes.randomElement() ?? EmojiMemoryGame.themes[0]
        theme.content.shuffle()
        model = EmojiMemoryGame.createMemoryGame(with: theme)
    }
    
    
    private static func createMemoryGame(with theme: Theme) -> MemoryGame<String> {
        MemoryGame<String>(numbersOfPairsOfCards: theme.numbersOfPairsOfCards) { index in
            return theme.content[index]
        }
    }

    // MARK: - Intent(s)
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func newGame() {
        if let newTheme = EmojiMemoryGame.themes.randomElement() {
            theme = newTheme
            theme.content.shuffle()
            model = EmojiMemoryGame.createMemoryGame(with: theme)
        }
    }
    
    func shuffle() {
        model.shuffle()
    }
}
