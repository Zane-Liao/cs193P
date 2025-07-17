//
//  Assignment3App.swift
//  Assignment3
//
//  Created by Zane Liao on 2025/7/9.
//

import SwiftUI

@main
struct Assignment3App: App {
    @StateObject var gameViewModel = SetGameViewModel()
    
    var body: some Scene {
        WindowGroup {
            SetGameView(viewModel: gameViewModel)
        }
    }
}
