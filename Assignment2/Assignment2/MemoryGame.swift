//
//  MemorizeGame.swift
//  Memorize
//  Model

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    // Store all card array
    private(set) var cards: Array<Card>
    
    private(set) var score = 0
    
    // Create card pair, cardContentFactoty with Closures
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content: CardContent = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
    }
    
    // Tracks face-up card index
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { index in cards[index].isFaceUp }.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) } }
    }
    
    // Choose card
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        score += 2
                    } else {
                        score -= 1
                    }
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    // Shuffle the cards(random)
    mutating func shuffle() {
        cards.shuffle()
    }
    
    // Choose theme
    mutating func theme() {
        cards.shuffle()
    }
    
    // Define card properties
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        var id: String
        
        var debugDescription: String {
            "\(id): \(content)"
        }
    }
}

// indexOfTheOneAndOnlyFaceUpCard...
extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
