//
//  Theme.swift
//  Memorize
//
//  Created by Anderson Chen on 2022/7/9.
//

import Foundation

struct Theme {
    let topic: String
    var content: [String]
    let numbersOfPairsOfCards: Int
    let themeColor: String
    
    init(topic: String, content: [String], numberOfPairsOfCards: Int, themeColor: String) {
        self.topic = topic
        self.content = content
        self.numbersOfPairsOfCards = numberOfPairsOfCards > content.count ? content.count : numberOfPairsOfCards
        self.themeColor = themeColor
    }
}
