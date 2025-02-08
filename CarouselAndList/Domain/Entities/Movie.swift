//
//  Movie.swift
//  MovieList
//
//  Created by Furkan ic on 10.11.2024.
//

import Foundation


// MARK: - Movie
struct Movie: Codable {
    var id = UUID()
    let imageURLString: String?
    let name, explanation: String?
    var type: String?
    
    enum CodingKeys: String, CodingKey {
        case imageURLString = "imageUrl"
        case type, name, explanation
    }
    
    mutating func setType(_ type: String) {
        self.type = type
    }
    
    func setID() -> Self {
        var movie = self
        movie.id = UUID()
        return movie
    }
}

extension Movie: Identifiable, Hashable, Equatable {}

extension Movie {
    var imageURL: URL? {
        guard let imageURLString else { return nil }
        return URL(string: imageURLString)
    }
}
