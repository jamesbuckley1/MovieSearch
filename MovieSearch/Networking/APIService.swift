//
//  APIService.swift
//  MovieSearch
//
//  Created by James Buckley on 27/11/2022.
//

import Foundation

class APIService {
    
//    func fetchMovieResults() async throws {
//        let movieUrlString = APIConstants.endpoint.rawValue
//        if let url = URL(string: movieUrlString) {
//            //defer is refreshing
//            do {
//                let (data, response) = try await URLSession.shared.data(from: url)
//                
//                guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode <= 299 else {
//                    throw MovieError.invalidStatusCode
//                }
//                
//                let decoder = JSONDecoder()
//                guard let movies = try? decoder.decode([Movie].self, from: data) else {
//                    throw MovieError.failedToDecode
//                }
//            } catch {
//                throw MovieError.custom(error: error)
//            }
//            
//        }
//    }
    
    func fetchMovies(searchTerm: String, completion: @escaping(Result<MovieResult, APIError>) -> Void) {
        let url = createMovieSearchURL(for: searchTerm)
        fetch(type: MovieResult.self, url: url, completion: completion)
    }
    
    func fetchMovieDetail(imdbId: String, completion: @escaping(Result<MovieDetail, APIError>) -> Void) {
        let url = createMovieDetailURL(for: imdbId)
        fetch(type: MovieDetail.self, url: url, completion: completion)
    }
    
    func createMovieSearchURL(for searchTerm: String) -> URL? {
        let baseURL = APIConstants.endpoint.rawValue
        let searchTermFormatted = searchTerm.replacingOccurrences(of: " ", with: "+")
        var queryItems = [URLQueryItem(name: "s", value: searchTermFormatted),
                          URLQueryItem(name: "apikey", value: APIConstants.apiKey.rawValue)]
        
        var components = URLComponents(string: baseURL)
        components?.queryItems = queryItems
        return components?.url

    }
    
    func createMovieDetailURL(for imdbId: String) -> URL? {
        let baseURL = APIConstants.endpoint.rawValue
        var queryItems = [URLQueryItem(name: "i", value: imdbId),
                          URLQueryItem(name: "apikey", value: APIConstants.apiKey.rawValue)]
        var components = URLComponents(string: baseURL)
        components?.queryItems = queryItems
        return components?.url
    }
    
    func fetch<T: Decodable>(type: T.Type, url: URL?, completion: @escaping(Result<T, APIError>) -> Void) {
        guard let url = url else {
            let error = APIError.invalidUrl
            completion(Result.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error as? URLError {
                print("ERROR: \(error.localizedDescription)")
                completion(Result.failure(APIError.custom(error: error)))
            } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(Result.failure(APIError.badResponse(responseCode: response.statusCode)))
            } else if let data = data {
                print(response)
                print(data)
                do {
                    let result = try JSONDecoder().decode(type, from: data)
                    print(result)
                    completion(Result.success(result))
                } catch {
                    completion(Result.failure(.failedToDecode(error as? DecodingError)))
                }
            }
        }
        .resume()
    }
}

enum APIError: LocalizedError {
    case invalidUrl
    case badResponse(responseCode: Int)
    case failedToDecode(DecodingError?)
    case custom(error: Error)
}
