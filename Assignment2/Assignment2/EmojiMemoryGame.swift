//
//  EmojiMemoryGame.swift
//  Memorize
//  ViewModel

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    private static let themes: [Theme] = [
        Theme(name: "Blue", emojis: ["😨", "😰", "🥶", "🚙" , "🐳" , "🌐" , "🚎", "🐟"], numberOfPairs: 8, color: .blue),
        Theme(name: "Red", emojis: ["😡", "🤬", "🐙", "🦐", "🦑", "🚘"], numberOfPairs: 6, color: .red),
        Theme(name: "Green", emojis: ["🐸", "🤢", "🐲", "🦖"], numberOfPairs: 4, color: .green),
        Theme(name: "Pink", emojis: ["🧞‍♀️", "🦩"], numberOfPairs: 2, color: .pink),
        Theme(name: "Brown", emojis: ["🐴", "🐻", "🐌", "🐶", "🦤", "🐡"], numberOfPairs: 6, color: .brown),
        Theme(name: "Yellow", emojis: ["👻", "🎃", "🦇", "🧛", "⚰️", "🪄", "🔮", "🧿", "🦄", "🍭", "🧙", "🧌"], numberOfPairs: 12, color: .yellow),
        Theme(name: "Purple", emojis: ["👿", "🙆🏿‍♀️", "👾", "☯️", "☔️", "🌂", "😈", "🍠"], numberOfPairs: 8, color: .purple)
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
    var cards: Array<Card> {
        return model.cards
    }
    
    // Score
    var score: Int {
        model.score
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
}
