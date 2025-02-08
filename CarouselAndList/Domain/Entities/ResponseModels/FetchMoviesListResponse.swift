//
//  FetchMoviesListResponse.swift
//  MovieList
//
//  Created by Furkan ic on 10.11.2024.
//


// MARK: - FetchMoviesListResponse
struct FetchMoviesListResponse: Codable {
    var bannerList: [Movie]?
    var combinedList: [Movie]?
}
