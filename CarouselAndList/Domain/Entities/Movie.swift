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
    let type, name, explanation: String?

    enum CodingKeys: String, CodingKey {
        case imageURLString = "imageUrl"
        case type, name, explanation
    }
}

extension Movie: Identifiable, Hashable, Equatable {}

extension Movie {
    var imageURL: URL? {
        guard let imageURLString else { return nil }
        return URL(string: imageURLString)
    }
}
