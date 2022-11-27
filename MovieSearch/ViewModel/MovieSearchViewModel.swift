//
//  MovieListViewModel.swift
//  MovieSearch
//
//  Created by James Buckley on 27/11/2022.
//

import Combine
import Foundation

class MovieSearchViewModel: ObservableObject {
    @Published var movies = [Movie]()
    @Published var isLoading: Bool = false
    @Published var searchSuccessful: Bool = false
    @Published var showAlert: Bool = false
    @Published var errorMessage: String = ""
    
    let service = APIService()
    
    var searchTerm: String = ""

    func fetchMovies(for searchTerm: String) {
        isLoading = true
        errorMessage = ""
        showAlert = false
        
        service.fetchMovies(searchTerm: searchTerm) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let results):
                    self?.movies = results.Search
                    self?.searchSuccessful = true
                case .failure(let error):
                    self?.errorMessage = error.description
                    self?.showAlert = true
                }
                self?.isLoading = false
            }
        }
    }
}
