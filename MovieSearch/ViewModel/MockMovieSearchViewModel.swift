//
//  MockMovieSearchViewModel.swift
//  MovieSearch
//
//  Created by James Buckley on 28/11/2022.
//

import Combine
import Foundation

class MockMovieSearchViewModel: ObservableObject {
    @Published var movies = [Movie]()
    @Published var isLoading: Bool = false
    @Published var searchSuccessful: Bool = false
    @Published var showAlert: Bool = false
    
    var searchTerm: String = ""
    var errorMessage: String = ""
    var page = 1

    func fetchMovies(for searchTerm: String, completion: @escaping (Bool) -> Void) {
        isLoading = true
        errorMessage = ""
        searchSuccessful = false
        showAlert = false
        
        APIService.shared.fetchMovies(searchTerm: searchTerm, page: page) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.movies = response.results
                    self?.searchSuccessful = true
                case .failure(let error):
                    self?.errorMessage = error.description
                    self?.showAlert = true
                }
                self?.isLoading = false
                completion(true)
            }
        }
    }
}
