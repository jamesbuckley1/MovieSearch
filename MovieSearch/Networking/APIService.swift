//
//  APIService.swift
//  MovieSearch
//
//  Created by James Buckley on 27/11/2022.
//

import Foundation

class APIService {
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
        let queryItems = [URLQueryItem(name: "s", value: searchTermFormatted),
                          URLQueryItem(name: "apikey", value: APIConstants.apiKey.rawValue)]
        
        var components = URLComponents(string: baseURL)
        components?.queryItems = queryItems
        return components?.url

    }
    
    func createMovieDetailURL(for imdbId: String) -> URL? {
        let baseURL = APIConstants.endpoint.rawValue
        let queryItems = [URLQueryItem(name: "i", value: imdbId),
                          URLQueryItem(name: "apikey", value: APIConstants.apiKey.rawValue)]
        var components = URLComponents(string: baseURL)
        components?.queryItems = queryItems
        return components?.url
    }
    
    func fetch<T: Decodable>(type: T.Type, url: URL?, completion: @escaping(Result<T, APIError>) -> Void) {
        guard let url = url else {
            let error = APIError.urlError
            completion(Result.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let err = error as? URLError {
                if err.code == URLError.Code.notConnectedToInternet {
                    completion(Result.failure(APIError.noInternet))
                } else {
                    completion(Result.failure(APIError.urlError))
                }
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

enum APIError: Error {
    case urlError
    case badResponse(responseCode: Int)
    case failedToDecode(DecodingError?)
    case noInternet

    var description: String {
        switch self {
        case .urlError:
            return "Invalid URL"
        case .badResponse(responseCode: let responseCode):
            return "Bad response: \(responseCode)"
        case .failedToDecode(_):
            return "Failed to decode response"
        case .noInternet:
            return "Internet connection unavailable"
        }
    }
}

