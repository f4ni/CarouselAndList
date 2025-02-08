//
//  ViewModel.swift
//  CarouselAndList
//
//  Created by Furkan ic on 6.02.2025.
//

import SwiftUI
import Combine


final class ViewModel: ObservableObject {
    
    var repository: MoviesRepositoryInterface
    @Published var movieList: FetchMoviesListResponse?
    @Published var selection: Movie?
    @Published var searchText: String = ""
    var filteredMovies: [Movie] {
        filterMovies()
    }
    var types: [String] {
        Array(Set(movieList?.combinedList?.compactMap({$0.type}) ?? [])).sorted()
    }
    var cancellables = Set<AnyCancellable>()
    @Published var errorMessage: String = "" {
        didSet {
            showAlert = !errorMessage.isEmpty
        }
    }
    @Published var showAlert: Bool = false
    @Published var isLoading: Bool = false
    
    init(repository: MoviesRepositoryInterface = MoviesRepository()) {
        self.repository = repository
    }
    
    @MainActor
    func fetchMovies() {
        isLoading = true
        Task { [weak self] in
            guard let self else { return }
            do {
                async let movieList = try await self.repository.fetchMovies()
                try await print(movieList)
                if await ((try movieList.bannerList?.isEmpty) != nil) {
                    self.movieList = try await movieList
                    try await setTypes(for: movieList.bannerList, with: movieList.combinedList?.compactMap{$0.type})
                    self.fabricateMoview()
                }
            } catch {
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }
    
    private func setTypes(for bannerMovies: [Movie]?, with types: [String]?) {
        guard let types, let bannerMovies else { return }
        movieList?.bannerList = bannerMovies.map { movie in
            guard movie.type == nil else { return movie }
            var mv = movie
            let type = types.randomElement() ?? "A"
            mv.setType(type)
            return mv
        }
        selection = movieList?.bannerList?.first
    }
    
    private func fabricateMoview() {
        var fabricated = [
            movieList?.combinedList,
            movieList?.combinedList,
            movieList?.combinedList,
            movieList?.combinedList,
            movieList?.combinedList,
            movieList?.combinedList
        ]
            .compactMap(\.self)
            .flatMap { $0 }
        fabricated = fabricated.map { $0.setID() }

        movieList?.combinedList = fabricated
    }
    
    private func filterMovies() -> [Movie] {
        let moviesInSelectedType = movieList?.combinedList?.filter({$0.type == selection?.type})
        
        guard !searchText.isEmpty else { return moviesInSelectedType ?? [] }
        

        return moviesInSelectedType?.filter { movie in
            // Check if any of the properties contain the search string (case-insensitive)
            let containsInName = movie.name?.localizedCaseInsensitiveContains(searchText) ?? false
            let containsInExplanation = movie.explanation?.localizedCaseInsensitiveContains(searchText) ?? false
            let containsInType = movie.type?.localizedCaseInsensitiveContains(searchText) ?? false
            
            // Return true if the search string is found in any of the properties
            return containsInName || containsInExplanation || containsInType
        } ?? []
    }
    
    func listOfMoviesNames() -> String {
        "listOf(\(filteredMovies.compactMap({ "\"\($0.name ?? "")\""}).joined(separator: ", ")))"
    }
    
    func countOfMovies() -> String {
        "\(selection?.type ?? "") (\(filteredMovies.count)) items"
    }
    
    func getTopOccurringForList() -> String {
        topThreeOccurringCharactersInString(filteredMovies.compactMap(\.name).joined(separator: "").replacingOccurrences(of: " ", with: ""))
    }
    
    private func topThreeOccurringCharactersInString(_ input: String?) -> String {
        guard let input = input else { return "" }
        
        var frequencyMap: [Character: Int] = [:]
        
        for character in input {
            frequencyMap[character, default: 0] += 1
        }
        
        let sortedCharactersByFrequency = frequencyMap.sorted { $0.value > $1.value }
        
        return sortedCharactersByFrequency.prefix(3).map{ "\($0.key) = \($0.value)" }.joined(separator: "\n")
    }
}
