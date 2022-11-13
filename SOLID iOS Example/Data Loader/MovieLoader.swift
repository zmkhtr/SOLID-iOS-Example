//
//  MovieLoader.swift
//  SOLID iOS Example
//
//  Created by Azam Mukhtar on 12/11/22.
//

import Foundation

enum NetworkError: Error {
    case unexpectedData
    case networkError
}

struct RemoteMovie: Decodable {
    let id, title, original_title, original_title_romanised: String
    let image, movie_banner: URL
    let description, director, producer, release_date: String
    let running_time, rt_score: String
    let people, species, locations, vehicles: [String]
    let url: String
}

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


