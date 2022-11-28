//
//  Movie.swift
//  MovieSearch
//
//  Created by James Buckley on 27/11/2022.
//

import Foundation

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
