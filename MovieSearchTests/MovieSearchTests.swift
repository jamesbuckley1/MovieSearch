//
//  MovieSearchTests.swift
//  MovieSearchTests
//
//  Created by James Buckley on 27/11/2022.
//

import XCTest
@testable import MovieSearch

final class MovieSearchTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_MovieSearchViewModel_fetchesMoviesTitledStarWars() {
        let vm = MockMovieSearchViewModel()
        
        vm.fetchMovies(for: "Star Wars") { success in
            if success {
                XCTAssertTrue(vm.movies.count > 0)
            }
        }
    }
    
    func test_MovieDetailViewModel_fetchesMovieWithId_tt0080684() {
        let id = "tt0080684"
        let title = "Star Wars: Episode V - The Empire Strikes Back"
        
        let movie = Movie(id: id, title: title, poster: "", year: "")
        let vm = MockMovieDetailViewModel(movie: movie)
        
        vm.fetchMovieDetail(for: movie.id) { movieDetail in
            XCTAssertEqual(movieDetail.title, movie.title)
        }
    }
    
    func test_APIService_searchQueryURLGeneration_forQueryStarWars_isValid() {
        let searchTerm = "Star Wars"
        let expectedUrl = "https://www.omdbapi.com/?s=Star+Wars&apikey=\(APIConstants.apiKey.rawValue)&page=1"
        
        let apiService = APIService()

        if let url = apiService.createMovieSearchURL(for: searchTerm, page: 1) {
            XCTAssertEqual(url.absoluteString, expectedUrl)
        }
    }
    
    func test_APIService_idQueryURLGeneration_forQuery_tt0080684_isValid() {
        let id = "tt0080684"
        let expectedUrl = "https://www.omdbapi.com/?i=\(id)&apikey=\(APIConstants.apiKey.rawValue)"
        
        let apiService = APIService()
        
        if let url = apiService.createMovieDetailURL(for: id) {
            XCTAssertEqual(url.absoluteString, expectedUrl)
        }
    }

}
