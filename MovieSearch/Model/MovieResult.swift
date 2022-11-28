//
//  MovieResult.swift
//  MovieSearch
//
//  Created by James Buckley on 28/11/2022.
//

import Foundation

struct MovieResult: Codable {
    let results: [Movie]
    let totalResults: String
    
    private enum CodingKeys: String, CodingKey {
        case results = "Search"
        case totalResults
    }
}
