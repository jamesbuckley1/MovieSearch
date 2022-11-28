//
//  MovieDetail.swift
//  MovieSearch
//
//  Created by James Buckley on 28/11/2022.
//

import Foundation

struct MovieDetail: Codable {
    let title: String
    let released: String
    let runtime: String
    let actors: String
    let plot: String
    let poster: String
    let imdbRating: String
    
    private enum CodingKeys: String, CodingKey {
        case title = "Title"
        case released = "Released"
        case runtime = "Runtime"
        case actors = "Actors"
        case plot = "Plot"
        case poster = "Poster"
        case imdbRating
    }
}
