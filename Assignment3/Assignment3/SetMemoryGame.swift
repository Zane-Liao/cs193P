//
//  CardAttribute.swift
//  Assignment3
//
//  Created by Zane Liao on 2025/7/8.
//  ViewModel

import SwiftUI
internal import Combine

// Draw Triangle
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let top = CGPoint(x: rect.midX, y: rect.midY)
        let bottomLeft = CGPoint(x: rect.minX, y: rect.maxY)
        let bottomRight = CGPoint(x: rect.maxX, y: rect.maxY)
        
        path.move(to: top)
        path.addLine(to: bottomLeft)
        path.addLine(to: bottomRight)
        path.closeSubpath()
        
        return path
    }
}

// Draw Ellipse
struct CustomEllipse: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addEllipse(in: rect)
        return path
    }
}

// Draw Diamond
struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let top = CGPoint(x: rect.midX, y: rect.minY)
        let right = CGPoint(x: rect.maxX, y: rect.midY)
        let bottom = CGPoint(x: rect.midX, y: rect.maxY)
        let left = CGPoint(x: rect.minX, y: rect.midY)

        path.move(to: top)
        path.addLine(to: right)
        path.addLine(to: bottom)
        path.addLine(to: left)
        path.closeSubpath()

        return path
    }
}

// CardShape
enum ShapeType {
    case triangle
    case ellipse
    case diamond
}

// Card
enum FillStyle {
    case solid
    case striped
    case open
}

class Card: Identifiable, ObservableObject, Hashable {
    let id = UUID()
    var shape: ShapeType
    var color: Color
    var count: Int
    var shading: FillStyle
    
    @Published var isSelected: Bool = false
    
    // Hashable 实现
    static func == (lhs: Card, rhs: Card) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    init(shape: ShapeType, color: Color, count: Int, shading: FillStyle) {
        self.shape = shape
        self.color = color
        self.count = count
        self.shading = shading
    }
}


class SetGameViewModel: ObservableObject {
    @Published var cards: [Card] = []

    private var selectedCards: [Card] {
        cards.filter { $0.isSelected }
    }

    init() {
        cards = generateCards()
    }

    func select(_ card: Card) {
        guard let index = cards.firstIndex(where: { $0.id == card.id }) else { return }

        if cards[index].isSelected {
            cards[index].isSelected = false
        } else {
            if selectedCards.count < 3 {
                cards[index].isSelected = true
            } else {
                if isSet(selectedCards) {
                    for selectedCard in selectedCards {
                        if let i = cards.firstIndex(where: { $0.id == selectedCard.id }) {
                            cards.remove(at: i)
                        }
                    }
                } else {
                    for i in cards.indices {
                        cards[i].isSelected = false
                    }
                }
                cards[index].isSelected = true
            }
        }
    }

    func isSet(_ cards: [Card]) -> Bool {
        guard cards.count == 3 else { return false }

        func allSameOrAllDifferent<T: Hashable>(_ values: [T]) -> Bool {
            return Set(values).count == 1 || Set(values).count == 3
        }

        let shapes = cards.map { $0.shape }
        let colors = cards.map { $0.color }
        let fillings = cards.map { $0.shading }
        let numbers = cards.map { $0.count }

        return allSameOrAllDifferent(shapes)
            && allSameOrAllDifferent(colors)
            && allSameOrAllDifferent(fillings)
            && allSameOrAllDifferent(numbers)
    }

    func generateCards() -> [Card] {
        var generated: [Card] = []
        let colors: [Color] = [.red, .green, .blue]
        let shapes: [ShapeType] = [.diamond, .triangle, .ellipse]
        let fillings: [FillStyle] = [.solid, .striped, .open]

        for color in colors {
            for shape in shapes {
                for shading in fillings {
                    for count in 1...3 {
                        generated.append(Card(shape: shape, color: color, count: count, shading: shading))
                    }
                }
            }
        }

        return Array(generated.shuffled().prefix(21))
    }
}


func generateDeck() -> [Card] {
    var deck = [Card]()
    let colors: [Color] = [.red, .green, .blue]
    let shapes: [ShapeType] = [.diamond, .triangle, .ellipse]
    let fillings: [FillStyle] = [.solid, .striped, .open]

    for color in colors {
        for shape in shapes {
            for filling in fillings {
                for count in 1...3 {
                    deck.append(Card(shape: shape, color: color, count: count, shading: filling))
                }
            }
        }
    }
    return deck
}
