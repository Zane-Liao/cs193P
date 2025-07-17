//
//  SetGame.swift
//  Assignment3
//
//  Created by Zane Liao on 2025/7/9.
//

import Foundation

struct SetGame {
    private(set) var cards: [Card]
    private(set) var score: Int = 0

    private var selectedIndices: [Int] {
        cards.indices.filter { index in
            cards[index].isSelected
        }
    }

    init() {
        cards = SetGame.generateInitialCards()
    }
    
    enum MatchStatus {
        case unmatched
        case matched
        case mismatched
    }

    struct Card: Identifiable, Equatable, Hashable {
        let id = UUID()
        let shape: ShapeType
        let color: CardColor
        let count: Int
        let shading: Shading
        var isSelected: Bool = false
        var matchStatus: MatchStatus = .unmatched
    }
    

    mutating func select(_ card: Card) {
        if cards.contains(where: { $0.matchStatus == .matched }) {
            cards.removeAll { $0.matchStatus == .matched }
        }
        
        let mismatchedIndices = cards.indices.filter { cards[$0].matchStatus == .mismatched }
        if !mismatchedIndices.isEmpty {
            for index in mismatchedIndices {
                cards[index].matchStatus = .unmatched
                cards[index].isSelected = false
            }
        }
        
        guard let tappedIndex = cards.firstIndex(where: { $0.id == card.id }) else {
            return
        }

        if cards[tappedIndex].matchStatus != .unmatched {
            return
        }
        

        cards[tappedIndex].isSelected.toggle()
        
        let currentSelectedIndices = selectedIndices
        if currentSelectedIndices.count == 3 {
            if isSet(indices: currentSelectedIndices) {
                score += 3
                for index in currentSelectedIndices {
                    cards[index].matchStatus = .matched
                }
            } else {
                score -= 1
                for index in currentSelectedIndices {
                    cards[index].matchStatus = .mismatched
                }
            }
        }
    }

    mutating func shuffle() {
        cards = SetGame.generateInitialCards()
        score = 0
    }

    private func isSet(indices: [Int]) -> Bool {
        guard indices.count == 3 else { return false }
        let selected = indices.map { cards[$0] }
        
        func allSameOrAllDifferent<T: Hashable>(_ values: [T]) -> Bool {
            let uniqueValues = Set(values)
            return uniqueValues.count == 1 || uniqueValues.count == 3
        }
        
        return allSameOrAllDifferent(selected.map { $0.shape }) &&
               allSameOrAllDifferent(selected.map { $0.color }) &&
               allSameOrAllDifferent(selected.map { $0.shading }) &&
               allSameOrAllDifferent(selected.map { $0.count })
    }
    
    enum ShapeType: CaseIterable { case diamond, triangle, ellipse }
    enum CardColor: CaseIterable { case red, green, blue }
    enum Shading: CaseIterable { case solid, striped, open }
    
    static func generateInitialCards() -> [Card] {
        var deck: [Card] = []
        for color in CardColor.allCases {
            for shape in ShapeType.allCases {
                for shading in Shading.allCases {
                    for count in 1...3 {
                        deck.append(Card(shape: shape, color: color, count: count, shading: shading))
                    }
                }
            }
        }
        return Array(deck.shuffled().prefix(21))
    }
}
