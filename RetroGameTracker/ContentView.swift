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
        NavigationStack {
            ZStack {
                switch viewModel.state {
                case .loaded(let gameList):
                    if gameList.isEmpty {
                        Text("No games found!")
                            .foregroundColor(.secondary)
                    } else {
                        List(gameList) { game in
                            Text(game.name)
                        }
                    }
                case .loading:
                    ProgressView("Loading...")
                case .error(let errorMessage):
                    Text(errorMessage)
                }
            }
            .navigationTitle("Games")
        }
        .task {
            await viewModel.loadGames()
        }
    }
}

#Preview {
    ContentView()
}
