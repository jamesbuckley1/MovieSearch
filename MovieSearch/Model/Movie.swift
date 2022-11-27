//
//  Movie.swift
//  MovieSearch
//
//  Created by James Buckley on 27/11/2022.
//

import Foundation

struct MovieResult: Codable {
    let Search: [Movie]
    
//    private enum CodingKeys: String, CodingKey {
//        case results = "Search"
//    }
}

struct Movie: Codable, Identifiable {
    let id: String
    let title: String
    let poster: String
    let year: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "imdbID"
        case title = "Title"
        case poster = "Poster"
        case year = "Year"
    }
}

struct MovieDetail: Codable {
    let title: String
    let year: String
    let rated: String
    let released: String
    let runtime: String
    let genre: String
    let director: String
    let writer: String
    let actors: String
    let plot: String
    let language: String
    let country: String
    let awards: String
    let poster: String
    let ratings: [MovieRating]
    let imdbRating: String
    let boxOffice: String
    
    private enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case poster = "Poster"
        case ratings = "Ratings"
        case imdbRating
        case boxOffice = "BoxOffice"
    }
}

struct MovieRating: Codable {
    let source: String
    let value: String
    
    private enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
}
