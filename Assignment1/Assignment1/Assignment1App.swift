//
//  Assignment1App.swift
//  Assignment1
//
//  Created by Zane Liao on 21/03/2025.
//

import SwiftUI

struct ContentView: View {
    var HalloweenThemeEmojis: Array<String> = ["👻", "🎃", "🦇","🧛","⚰️","🪄","🔮","🧿","🦄","🍭","🧙","🧌"]
    @State private var CarThemeEmojis: Array<String> = ["🚗", "🚌", "🚎", "🚚", "🏎️", "🦽", "🚋", "🚔", "🏍️", "🛺", "🚠", "🛴"]
    @State private var FestivalThemeEmojis: Array<String> = ["🎉", "🥳", "🎊", "🎁", "🎏", "🎄", "🎅", "🎅🏻", "🧑🏻‍🎄", "🤶🏼"]
    @State private var AnimalThemeEmojis: Array<String> = ["🐈", "🦞", "🐓", "🦤", "🦊", "🦝", "🐰", "🐄"]
    
    @State private var ThemeEmojis: Array<String>
    
    // Web Solutions
    let columns = [GridItem(.adaptive(minimum: 80)), GridItem(.adaptive(minimum: 80))]
    
    init() {
        _ThemeEmojis = State(initialValue: HalloweenThemeEmojis)
    }
    
    var body: some View {
        VStack {
            // Allows for user to scroll
            cardCountTitles
            ScrollView { cards }
            Spacer()
            cardCountTheme
        }
        .padding()
    }
    
    var cardCountTitles: some View {
        Text("Memorize!").font(.largeTitle)
    }
    
    var cards: some View {
        // creates a vertically scrollable collection of views
        // lazy implies that the views are only created when SwiftUI needs to display them
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(0..<ThemeEmojis.count, id: \.self) { index in
                    ZStack {
                        CardView(content: ThemeEmojis[index])
                        // web Solutions
                        // Everyone element 0+1=1, 1*2+1=3, insert
                        if index * 2 + 1 < ThemeEmojis.count {
                            CardView(content: ThemeEmojis[index * 2 + 1])
                        }
                    }
                    .aspectRatio(2/3, contentMode: .fit)
                }
            }
        }
        .foregroundColor(.red)
    }

    
    var cardCountTheme: some View {
        HStack(spacing: 30) {
            cardCountCarTheme(symbol: "car")
                .font(.system(size: 40))
            cardCountFestivalTheme(symbol: "tree")
                .font(.system(size: 35))
            cardCountAnimalTheme(symbol: "cat")
                .font(.system(size: 40))
        }
        .imageScale(.large)
    }
    
    func cardCountCarTheme(symbol: String) -> some View {
        Button(action: {
            cardCountThemeChoice(CarThemeEmojis)
            CarThemeEmojis.shuffle()
        }, label: {
            VStack {
                Image(systemName: symbol)
                    Text("Car")
                    .font(.system(size: 15))
            }
        })
    }
    
    func cardCountFestivalTheme(symbol: String) -> some View {
        Button(action: {
            cardCountThemeChoice(FestivalThemeEmojis)
            FestivalThemeEmojis.shuffle()
        }, label: {
            VStack {
                Image(systemName: symbol)
                    Text("Festival")
                    .font(.system(size: 15))
            }
        })
    }
    
    func cardCountAnimalTheme(symbol: String) -> some View {
        Button(action: {
            cardCountThemeChoice(AnimalThemeEmojis)
            AnimalThemeEmojis.shuffle()
        }, label: {
            VStack {
                Image(systemName: symbol)
                    Text("Animal")
                    .font(.system(size: 15))
            }
        })
    }
    
    func cardCountThemeChoice(_ Emojis: Array<String>) {
        ThemeEmojis = Emojis
    }
    
}

struct CardView: View {
    let content: String
    @State var isFaceUp = false
    let base = RoundedRectangle(cornerRadius: 12)
    
    var body: some View {
        ZStack {
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1:0)
            base.fill().opacity(isFaceUp ? 0:1)
        }.onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
