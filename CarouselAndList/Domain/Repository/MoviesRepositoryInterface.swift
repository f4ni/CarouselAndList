//
//  MoviesRepository.swift
//  MovieList
//
//  Created by Furkan ic on 10.11.2024.
//

protocol MoviesRepositoryInterface {
    func fetchMovies() async throws -> FetchMoviesListResponse
}
