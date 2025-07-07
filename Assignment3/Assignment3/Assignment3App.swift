//
//  Assignment3App.swift
//  Assignment3
//
//  Created by Zane Liao on 2025/7/7.
//

import SwiftUI

// @main -> int main() or fn main()
@main
struct Assignment3App: App {
    @StateObject var game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
