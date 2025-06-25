//
//  EmojiMemoryGameView.swift
//  Memorize
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            cardsThemeText("Jensen")
            ScrollView {
                cardsTheme
                    .animation(.default, value: viewModel.cards )
            }
            Button("Shuffle") {
                viewModel.shuffle()
            }
            Spacer()
            Button("New Theme") {
                viewModel.theme()
            }
        }
        .padding()
    }
    
    let colorArray: [Color] = [
        .red,
        .green,
        .blue,
        .yellow,
        .orange,
        .purple
    ]
    
    lazy var randomColor = colorArray.randomElement()!
    
    var cardCountTitles: some View {
        Text("Spring!").font(.largeTitle)
    }
    
    var cardsTheme: some View {
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
        .foregroundColor(.red)
    }

    func cardsTheme(color: Color) -> some View {
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
        .foregroundColor(color)
    }
    
    func cardsThemeText(_ text: String) -> some View {
        Text(text).font(.largeTitle)
    }
    
    func chooseTheme() -> cardsThemes {
        cardsThemes.allCases.randomElement()!
    }
    
    enum cardsThemes: CaseIterable {
        case cardsThemeBlue, cardsThemeGreen, cardsThemeYellow, cardsThemeRed, cardsThemePink, cardsThemeBrown
    }
    
    
}

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
