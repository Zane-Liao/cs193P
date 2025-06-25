//
//  EmojiMemoryGame.swift
//  Memorize

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private static let emojis = ["👻", "🎃", "🦇","🧛","⚰️","🪄","🔮","🧿","🦄","🍭","🧙","🧌"]
    @State private static var blueEmojis = ["", "", "", "" , "" , "" , "", ""]
    @State private static var Redemojis = ["", "", "", "", ""]
    @State private static var Greenemojis = ["", "", "", ""]
    @State private static var pinkEmojis = ["", "", "", ""]
    @State private static var brownEmojis = ["", "", "", "", "", ""]
    @State private static var secondEmojis = ["", "", "", "", "", "", ""]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame<String>(numberOfPairsOfCards: 8) { pairIndex in
            if emojis.indices.contains(pairIndex){
                emojis[pairIndex]
            } else {
                "⁉️"
            }
        }
    }
    
    @Published private var model = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func theme() {
        model.theme()
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
