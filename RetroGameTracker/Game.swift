//
//  Game.swift
//  RetroGameTracker
//
//  Created by Matthew Young on 5/5/26.
//

import Foundation

struct Game: Codable, Identifiable {
    let id : Int
    let name : String
    let released : String?
    let backgroundImage: String?
    let rating: Double?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case released
        case backgroundImage = "background_image"
        case rating
    }
}
