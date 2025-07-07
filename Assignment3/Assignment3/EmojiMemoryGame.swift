//
//  EmojiMemoryGame.swift
//  Assignment3
//
//  Created by Zane Liao on 2025/7/7.
//

import SwiftUI
internal import Combine

class EmojiMemoryGame: ObservableObject {
    private static let emojis = [""]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame<String>(numberOfPairsOfCards: 11) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                emojis[pairIndex]
            } else {
                ""
            }
        }
    }
    
    @Published private var model = createMemoryGame()
    
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
