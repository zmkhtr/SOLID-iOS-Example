//
//  MovieLoader.swift
//  SOLID iOS Example
//
//  Created by Azam Mukhtar on 12/11/22.
//

import Foundation

class MovieLoader {
    
    private let url: URL
    private let client: URLSession
    
    init(url: URL, client: URLSession) {
        self.url = url
        self.client = client
    }
    
    typealias Result = Swift.Result<[Movie], Error>
    
    func getMovieList(completion: @escaping (Result) -> Void) {
        
        client.dataTask(with: url) { [weak self] (data, response, error) in
            guard self != nil else { return  }
                if let data = data,
                   let response = response as? HTTPURLResponse {
                    completion(MovieLoader.map(data, from: response))
                } else {
                    completion(.failure(NetworkError.networkError))
                }
        }.resume()
    }
    
    private static func map(_ data: Data, from response: HTTPURLResponse) -> Result {
        do {
            let movies = try MovieItemMapper.map(data, from: response)
            return .success(movies)
        } catch {
            return .failure(error)
        }
    }
}



