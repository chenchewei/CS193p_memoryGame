//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Anderson Chen on 2022/6/20.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
