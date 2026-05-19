//
//  GameListViewModel.swift
//  RetroGameTracker
//
//  Created by Matthew Young on 5/18/26.
//

import Foundation
import Combine

enum ViewState {
    case loading
    case error(String)
    case loaded([Game])
}

@MainActor
class GameListViewModel: ObservableObject {
    @Published var state: ViewState = .loading
    
    func loadGames() async {
        let service = RAWGAPIService()
        
        state = .loading
        
        do {
            state = .loaded(try await service.fetchTopGames())
        } catch {
            print("Error Occurred: \(error)")
            state = .error(error.localizedDescription)
        }
        
    }
}
