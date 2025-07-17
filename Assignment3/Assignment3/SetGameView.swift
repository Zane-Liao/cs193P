//
//  SetGameView.swift
//  Assignment3
//
//  Created by Zane Liao on 2025/7/9.
//

import SwiftUI


struct SetGameView: View {
    @ObservedObject var viewModel: SetGameViewModel

    let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 10), count: 3)

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(viewModel.cards) { card in
                    CardView(card: card)
                        .onTapGesture {
                            viewModel.select(card)
                        }
                        .aspectRatio(2/3, contentMode: .fit)
                }
            }
            .padding()
        }
    }
}


struct CardView: View {
    let card: Card

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(Color.gray, lineWidth: 2)
                .background(Color.white)

            VStack(spacing: 6) {
                ForEach(0..<card.count, id: \.self) { _ in
                    StyledShape(shape: shapeFromType(card.shape),
                                color: card.color,
                                style: card.shading)
                        .frame(width: 60, height: 40)
                }
            }
            .padding(10)
        }
        .aspectRatio(2/3, contentMode: .fit)
    }

    func shapeFromType(_ type: ShapeType) -> AnyShape {
        switch type {
        case .triangle: return AnyShape(Triangle())
        case .diamond:  return AnyShape(Diamond())
        case .ellipse:  return AnyShape(CustomEllipse())
        }
    }
}

struct AnyShape: Shape {
    private let _path: (CGRect) -> Path

    init<S: Shape>(_ shape: S) {
        _path = { rect in shape.path(in: rect) }
    }

    func path(in rect: CGRect) -> Path {
        _path(rect)
    }
}



// Set Display
struct StyledShape<Content: Shape>: View {
    let shape: Content
    let color: Color
    let style: FillStyle

    var body: some View {
        ZStack {
            switch style {
            case .solid:
                shape.fill(color)

            case .open:
                shape.stroke(color, lineWidth: 2)

            case .striped:
                shape.stroke(color, lineWidth: 2)
                stripedOverlay().clipShape(shape)
            }
        }
    }

    private func stripedOverlay() -> some View {
        GeometryReader { geo in
            Path { path in
                let spacing: CGFloat = 4
                var y: CGFloat = 0
                while y < geo.size.height {
                    path.move(to: CGPoint(x: 0, y: y))
                    path.addLine(to: CGPoint(x: geo.size.width, y: y))
                    y += spacing
                }
            }
            .stroke(color.opacity(0.4), lineWidth: 1)
        }
    }
}


#Preview {
    SetGameView(viewModel: SetGameViewModel())
}
