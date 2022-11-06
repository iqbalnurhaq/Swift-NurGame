//
//  Game.swift
//  NurGame
//
//  Created by Iqbal Nur Haq on 06/11/22.
//

import Foundation


struct Games: Codable {
    let title: String?
    let description: String?
    let game: [Game]?
    
    enum CodingKeys: String, CodingKey {
        case title = "seo_title"
        case description = "seo_description"
        case game = "results"
    }
}

struct Game: Codable {
    let id: Int
    let name: String
    let released: String
    let backgroundImage: String
    let rating: Int
    let genres: [GameGenre]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case released
        case backgroundImage = "background_image"
        case rating = "rating_top"
        case genres
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        released = try values.decode(String.self, forKey: .released)
        backgroundImage = try values.decode(String.self, forKey: .backgroundImage)
        rating = try values.decode(Int.self, forKey: .rating)
        genres = try values.decodeIfPresent([GameGenre].self, forKey: .genres)
    }
    
    init(
        id: Int,
        name: String,
        release: String,
        backgroundImage: String,
        rating: Int,
        genres: [GameGenre]?
    ){
        self.id = id
        self.name = name
        self.released = release
        self.backgroundImage = backgroundImage
        self.rating = rating
        self.genres = genres
    }
}


struct GameGenre: Codable {
    let id: Int?
    let name: String?
}
