//
//  ContentView.swift
//  Assignment3
//
//  Created by Zane Liao on 2025/7/7.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    // Any change to the @Published, EmojiMemoryGameView Re-reader body
    @ObservedObject var viewModel: EmojiMemoryGame
    private let aspectRatio: CGFloat = 2/3
    
    var body: some View {
        VStack {
            cardsThemeText(viewModel.theme.name)
            
            cards
                .animation(.default, value: viewModel.cards)
            Button("shuffle") {
                viewModel.shuffle()
            }
            Button("New Game") {
                            viewModel.newGame()
            }
        }
        .padding()

        HStack {
            Text("Score: \(viewModel.score)")
                 .font(.title2)
        }
        .padding(.bottom, 5)
    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            CardView(card)
                .padding(4)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
        .foregroundColor(viewModel.theme.color)
    }
    
    func cardsThemeText(_ text: String) -> some View {
        Text(text).font(.largeTitle)
    }
}

// Single card Display
struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1:0)
            base.fill()
                .opacity(card.isFaceUp ? 0:1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
