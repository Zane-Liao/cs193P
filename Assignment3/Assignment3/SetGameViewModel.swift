//
//  SetGameViewModel.swift
//  Assignment3
//
//  Created by Zane Liao on 2025/7/8.
//
import SwiftUI
import Combine

class SetGameViewModel: ObservableObject {
    @Published private var model = SetGame()

    var cards: [SetGame.Card] {
        model.cards
    }

    var score: Int {
        model.score
    }

    func select(_ card: SetGame.Card) {
        model.select(card)
    }

    func shuffle() {
        model.shuffle()
    }
}

