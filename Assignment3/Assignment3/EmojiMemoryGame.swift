//
//  EmojiMemoryGame.swift
//  Assignment3
//
//  Created by Zane Liao on 2025/7/7.
//

import SwiftUI
internal import Combine

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
        
    private static let themes: [Theme] = [
        Theme(name: "Blue", emojis: [
            "😨", "😰", "🥶", "🚙", "🐳", "🌐", "🚎", "🐟",
            "🧊", "🌊", "💎"
        ], numberOfPairs: 11, color: .blue),

        Theme(name: "Red", emojis: [
            "😡", "🤬", "🐙", "🦐", "🦑", "🚘",
            "❤️", "🍓", "🌶️", "🟥"
        ], numberOfPairs: 10, color: .red),

        Theme(name: "Green", emojis: [
            "🐸", "🤢", "🐲", "🦖",
            "🌲", "🥦", "🍀"
        ], numberOfPairs: 7, color: .green),

        Theme(name: "Pink", emojis: [
            "🧞‍♀️", "🦩",
            "🌸", "🎀", "🩷", "💖"
        ], numberOfPairs: 6, color: .pink),

        Theme(name: "Brown", emojis: [
            "🐴", "🐻", "🐌", "🐶", "🦤", "🐡",
            "🥔", "🌰", "🪵", "🍂"
        ], numberOfPairs: 10, color: .brown),

        Theme(name: "Yellow", emojis: [
            "👻", "🎃", "🦇", "🧛", "⚰️", "🪄", "🔮", "🧿", "🦄", "🍭", "🧙", "🧌",
            "🌕", "💛", "🐥", "⭐️"
        ], numberOfPairs: 16, color: .yellow),

        Theme(name: "Purple", emojis: [
            "👿", "🙆🏿‍♀️", "👾", "☯️", "☔️", "🌂", "😈", "🍠",
            "🔮", "🍇", "💜", "🪻"
        ], numberOfPairs: 12, color: .purple)
    ]

        
    // Any change to the Model (@Published -> View), private only (Model -> ViewModel)
    @Published private var model: MemoryGame<String>
    private(set) var theme: Theme
        
    init() {
        theme = EmojiMemoryGame.themes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(with: theme)
    }
        
    private static func createMemoryGame(with theme: Theme) -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairs) { pairIndex in
            theme.emojis[pairIndex]
        }
    }
        
    func newGame() {
        theme = EmojiMemoryGame.themes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(with: theme)
    }
    
    // Only read (Model.Card -> View)
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    // Score
    var score: Int {
        model.score
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
