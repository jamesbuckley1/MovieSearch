//
//  MockMovieDetailViewModel.swift
//  MovieSearch
//
//  Created by James Buckley on 28/11/2022.
//

import Foundation

import Foundation

class MockMovieDetailViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var showAlert: Bool = false
    @Published var movieDetail: MovieDetail?
    
    let movie: Movie
    
    var errorMessage: String = ""

    init(movie: Movie) {
        self.movie = movie
        fetchMovieDetail(for: movie.id) { _ in }
    }

    func fetchMovieDetail(for imdbId: String, completion: @escaping (MovieDetail) -> Void) {
        isLoading = true
        showAlert = false
        
        APIService.shared.fetchMovieDetail(imdbId: imdbId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    self?.movieDetail = result
                    completion(result)
                case .failure(let error):
                    self?.errorMessage = error.description
                    self?.showAlert = true
                }
                self?.isLoading = false
                
            }
        }
    }
}
