//
//  APIEndpoints.swift
//  MovieList
//
//  Created by Furkan ic on 10.11.2024.
//

import Foundation

var BASE_URL = "https://intertechtr.github.io"

enum APIEndpoints {
    case fetchMovies
}

extension APIEndpoints: NetworkRequest {
    
    var commonHeaders: [String : String] {
        ["Content-Type": "application/json"]
    }
    
    var baseUrl: URL {
        URL(string: BASE_URL)!
    }
    
    var path: String {
        switch self {
        case .fetchMovies:
            "/interview.json"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchMovies:
                .get
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .fetchMovies:
            nil
        }
    }
    
    var body: (any Encodable)? {
        switch self {
        case .fetchMovies:
            nil
        }
    }
    
    var queryItems: (any Encodable)? {
        switch self {
        case .fetchMovies:
            nil
        }
    }
}
