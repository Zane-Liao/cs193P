//
//  MemoryGame.swift
//  Assignment3
//
//  Created by Zane Liao on 2025/7/7.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) -> {
    }
    
    var IndexOfTheOneAndOnlyFaceUpCard: Int? {}
    
    mutating func choose() {}
    
    mutating func shuffle() {}
    
    struct Card: Equatable, Identifiable, CustomReflectable {}
    
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
