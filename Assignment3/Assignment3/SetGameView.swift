//
//  SetGameView.swift
//  Assignment3
//
//  Created by Zane Liao on 2025/7/9.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var viewModel: SetGameViewModel

    var body: some View {
        VStack {
            Text("Set Game")
                .font(.largeTitle)
                .padding(.top)

            AspectVGrid(viewModel.cards, aspectRatio: 2/3) { card in
                CardView(card: card)
                    .onTapGesture {
                        viewModel.select(card)
                    }
            }
            .padding(.horizontal)
            .animation(.default, value: viewModel.cards)

            Spacer()
            
            HStack {
                Text("Score: \(viewModel.score)")
                    .font(.title2)
                    .padding(.leading)
                Spacer()
                Button(action: {
                    viewModel.shuffle()
                }) {
                    Text("New Game")
                        .font(.title3)
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color.blue.opacity(0.15))
                        .cornerRadius(8)
                }
                .padding(.trailing)
            }
            .padding(.bottom)
        }
    }
}

struct CardView: View {
    let card: SetGame.Card

    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 10)
            base.fill(Color.white)
            base.strokeBorder(borderColor, lineWidth: 2.5)

            VStack {
                ForEach(0..<card.count, id: \.self) { _ in
                    StyledShape(
                        shape: shapeFromType(card.shape),
                        color: colorFor(card.color),
                        style: card.shading
                    )
                    .padding(.vertical, 4)
                }
            }
            .padding(10)
        }
    }
    
    private var borderColor: Color {
        switch card.matchStatus {
        case .matched:
            return .green
        case .mismatched:
            return .red
        case .unmatched:
            return card.isSelected ? .orange : .gray
        }
    }

    private func shapeFromType(_ type: SetGame.ShapeType) -> some Shape {
        switch type {
        case .triangle: return AnyShape(Triangle())
        case .diamond:  return AnyShape(Diamond())
        case .ellipse:  return AnyShape(Ellipse())
        }
    }

    private func colorFor(_ colorType: SetGame.CardColor) -> Color {
        switch colorType {
        case .red: .red
        case .green: .green
        case .blue: .blue
        }
    }
}


struct StyledShape<Content: Shape>: View {
    let shape: Content
    let color: Color
    let style: SetGame.Shading

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                switch style {
                case .solid:
                    shape.fill(color)
                case .open:
                    shape.stroke(color, lineWidth: 2)
                case .striped:
                    ZStack {
                        shape.stroke(color, lineWidth: 2)
                        StripedPattern(color: color, spacing: geometry.size.height / 8)
                            .clipShape(shape)
                    }
                }
            }
        }
    }
}

struct StripedPattern: View {
    let color: Color
    let spacing: CGFloat
    var body: some View {
        VStack(spacing: spacing) {
            ForEach(0..<5) { _ in
                color.frame(maxWidth: .infinity, maxHeight: 1)
            }
        }
        .opacity(0.7)
    }
}

struct AnyShape: Shape {
    private let _path: (CGRect) -> Path
    init<S: Shape>(_ shape: S) { _path = { rect in shape.path(in: rect) } }
    func path(in rect: CGRect) -> Path { _path(rect) }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.closeSubpath()
        }
    }
}

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
            path.closeSubpath()
        }
    }
}

#Preview {
    SetGameView(viewModel: SetGameViewModel())
}
