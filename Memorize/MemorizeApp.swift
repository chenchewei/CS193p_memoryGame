//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Anderson Chen on 2022/6/20.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
