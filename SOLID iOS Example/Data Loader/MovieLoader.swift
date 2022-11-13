//
//  MovieLoader.swift
//  SOLID iOS Example
//
//  Created by Azam Mukhtar on 12/11/22.
//

import Foundation

class MovieLoader {
    
    typealias MovieResult = Swift.Result<[RemoteMovie], Error>
    
    func getMovieList(completion: @escaping (MovieResult) -> Void) {
        let url = URL(string: "https://ghibliapi.herokuapp.com/films")!

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.sync {
                do {
                    if let data = data,
                       let response = response as? HTTPURLResponse,
                       response.statusCode == 200 {
                        let movies = try JSONDecoder().decode([RemoteMovie].self, from: data)
                        completion(.success(movies))
                    } else {
                        completion(.failure(NetworkError.unexpectedData))
                    }
                } catch {
                    completion(.failure(NetworkError.networkError))
                }
            }
        }.resume()
    }
}


