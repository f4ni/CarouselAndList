//
//  MoviesRepository.swift
//  MovieList
//
//  Created by Furkan ic on 10.11.2024.
//

struct MoviesRepository: MoviesRepositoryInterface {
    func fetchMovies() async throws -> FetchMoviesListResponse {
        try await NetworkClient().send(APIEndpoints.fetchMovies)
    }
}
