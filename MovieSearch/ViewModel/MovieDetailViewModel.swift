//
//  MovieListViewModel.swift
//  MovieSearch
//
//  Created by James Buckley on 27/11/2022.
//

import Foundation

class MovieDetailViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var showAlert: Bool = false
    @Published var movieDetail: MovieDetail?
    
    let movie: Movie
    
    var errorMessage: String = ""

    init(movie: Movie) {
        self.movie = movie
        fetchMovieDetail(for: movie.id)
    }

    func fetchMovieDetail(for imdbId: String) {
        isLoading = true
        showAlert = false
        errorMessage = ""
        
        if InternetConnectionManager.isConnectedToNetwork() {
            APIService.shared.fetchMovieDetail(imdbId: imdbId) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let result):
                        self?.movieDetail = result
                    case .failure(let error):
                        self?.errorMessage = error.description
                        self?.showAlert = true
                    }
                    self?.isLoading = false
                }
            }
        } else {
            errorMessage = APIError.noInternet.description
            showAlert = true
        }
        
        
    }
}
