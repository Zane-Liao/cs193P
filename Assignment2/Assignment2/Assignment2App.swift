//  MemorizeApp.swift


import SwiftUI

// @main -> int main() or fn main()
@main
struct Assignment2App: App {
    @StateObject var game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
