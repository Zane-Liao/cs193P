//  MemorizeApp.swift
//  Memorize

import SwiftUI

@main
struct Assignment2App: App {
    @StateObject var game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
