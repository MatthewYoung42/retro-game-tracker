//
//  ContentView.swift
//  RetroGameTracker
//
//  Created by Matthew Young on 5/4/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = GameListViewModel()
    
    var body: some View {
        ZStack {
            NavigationStack {
                List(viewModel.games) { game in
                    Text(game.name)
                }
                .task {
                    await viewModel.loadGames()
                }
                .navigationTitle("Games")
                .opacity(viewModel.isLoading && (viewModel.errorMessage == nil) ? 0 : 1)
            }
            if viewModel.isLoading {
                ProgressView("Loading...")
                    .transition(.opacity)
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
            }
        }
    }
}

#Preview {
    ContentView()
}
