//
//  RAWGAPIService.swift
//  RetroGameTracker
//
//  Created by Matthew Young on 5/7/26.
//

import Foundation

struct GameResponse: Decodable {
    let results: [Game]
}

class RAWGAPIService {
    private let apiKey: String = Bundle.main.infoDictionary?["RAWG_API_KEY"] as? String ?? ""
    private let baseURL: String = "api.rawg.io"
    
    func fetchTopGames(limit: Int = 10) async throws -> [Game] {
        let method = "/api/games"
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = baseURL
        urlComponents.path = method
        urlComponents.queryItems = [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "page_size", value: "\(limit)"),
            URLQueryItem(name: "ordering", value: "-added"),
            URLQueryItem(name: "exclude_additions", value: "true")
        ]
        
        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode, (200...299).contains(statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        let decodedResponse = try decoder.decode(GameResponse.self, from: data)
        
        return decodedResponse.results
    }
}
