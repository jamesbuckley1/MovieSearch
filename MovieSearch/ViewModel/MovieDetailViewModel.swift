//
//  MovieListViewModel.swift
//  MovieSearch
//
//  Created by James Buckley on 27/11/2022.
//

import Foundation

class MovieDetailViewModel: ObservableObject {
    let movie: Movie
    @Published var isLoading: Bool = false
    @Published var searchSuccessful: Bool = false
    @Published var errorMessage: String? = nil
    @Published var movieDetail: MovieDetail?
    
    let service = APIService()
    
    //var subscriptions = Set<AnyCancellable>()
    
    init(movie: Movie) {
        self.movie = movie
        fetchMovieDetail(for: movie.id)
    }

    func fetchMovieDetail(for imdbId: String) {
        isLoading = true
        searchSuccessful = false
        
        
        
        service.fetchMovieDetail(imdbId: imdbId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    self?.movieDetail = result
                    //completion(true)
                    self?.searchSuccessful = true
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    self?.errorMessage = error.localizedDescription
                    //completion(false)
                }
                
             
                self?.isLoading = false
                
            }
            
            
        }
    }
}
