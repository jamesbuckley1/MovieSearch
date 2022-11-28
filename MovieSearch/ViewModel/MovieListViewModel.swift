//
//  MovieListViewModel.swift
//  MovieSearch
//
//  Created by James Buckley on 27/11/2022.
//

import Combine
import Foundation

class MovieListViewModel: ObservableObject {
    @Published var movies = [Movie]()
    @Published var searchSuccessful: Bool = false
    @Published var showAlert: Bool = false
    
    var searchTerm: String = ""
    var errorMessage: String = ""
    var totalResults: Int = 0
    var page: Int = 1
    
    init(searchTerm: String) {
        self.searchTerm = searchTerm
        fetchMovies(for: searchTerm)
    }

    func fetchMovies(for searchTerm: String) {
        errorMessage = ""
        searchSuccessful = false
        showAlert = false
        
        if InternetConnectionManager.isConnectedToNetwork() {
            APIService.shared.fetchMovies(searchTerm: searchTerm, page: page) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let response):
                        self?.totalResults = Int(response.totalResults) ?? 0
                        
                        for movie in response.results {
                            self?.movies.append(movie)
                        }
                        self?.searchSuccessful = true
                    case .failure(let error):
                        self?.errorMessage = error.description
                        self?.showAlert = true
                    }

                    self?.page += 1
                }
            }
        } else {
            errorMessage = APIError.noInternet.description
            showAlert = true
        }
        
    }
    
    func fetchMore() {
        if page <= totalResults {
            fetchMovies(for: searchTerm)
        }
    }
}
