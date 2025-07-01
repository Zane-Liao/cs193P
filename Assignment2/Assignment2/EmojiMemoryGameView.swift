//
//  EmojiMemoryGameView.swift
//  View

import SwiftUI

struct EmojiMemoryGameView: View {
    // Any change to the @Published, EmojiMemoryGameView Re-reader body
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            cardsThemeText(viewModel.theme.name)
            
            ScrollView {
                cards
                    .animation(.default, value: viewModel.cards )
            }
            Button("Shuffle") {
                viewModel.shuffle()
            }
            Spacer()
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
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85),spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards) { card in
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
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
