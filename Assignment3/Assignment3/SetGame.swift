//
//  SetGame.swift
//  Assignment3
//
//  Created by Zane Liao on 2025/7/9.
//

import Foundation

struct SetGame<SetContent> where SetContent: Equatable {
    private(set) var cards: Array<SetCard>
    
    private var score = 0
    
    
    // Define Setcard properties
    struct SetCard: Equatable, Identifiable, CustomDebugStringConvertible {
        var debugDescription: String
        
        var isMarked = false
        var isFaceUp = false
        let content: SetContent
        var id: String
    }
    
    
}


