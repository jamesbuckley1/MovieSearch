//
//  MovieListViewModel.swift
//  MovieSearch
//
//  Created by James Buckley on 27/11/2022.
//

import Foundation
import Combine

class MovieSearchViewModel: ObservableObject {
    @Published var movies = [Movie]()
    @Published var isLoading: Bool = false
    @Published var searchSuccessful: Bool = false
    @Published var errorMessage: String? = nil
    
    var searchTerm: String = ""
    
    let service = APIService()
    
    //var subscriptions = Set<AnyCancellable>()
    
//    init() {
//        $searchTerm
//            .dropFirst()
//            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
//            .sink { [weak self] term in
//                self?.movies = []
//                self?.fetchMovies(for: term)
//            }.store(in: &subscriptions)
//    }

    func fetchMovies(for searchTerm: String) {
        isLoading = true
        searchSuccessful = false
        
        
        
        service.fetchMovies(searchTerm: searchTerm) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let results):
                    self?.movies = results.Search
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
