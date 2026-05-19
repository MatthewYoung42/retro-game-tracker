//
//  GameListViewModel.swift
//  RetroGameTracker
//
//  Created by Matthew Young on 5/18/26.
//

import Foundation
import Combine

@MainActor
class GameListViewModel: ObservableObject {
    @Published var games: [Game] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    func loadGames() async {
        let service = RAWGAPIService()
        
        isLoading = true
        errorMessage = nil
        
        do {
            self.games = try await service.fetchTopGames()
        } catch {
            print("Error Occurred: \(error)")
            errorMessage = error.localizedDescription
        }
        
        isLoading = false

    }
}
