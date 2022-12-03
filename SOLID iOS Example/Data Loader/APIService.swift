//
//  MovieLoader.swift
//  SOLID iOS Example
//
//  Created by Azam Mukhtar on 12/11/22.
//

import Foundation

class APIService {
    
    typealias CatFactResult = Swift.Result<[RemoteCatFact], Error>
    
    func getCatFacts(completion: @escaping (CatFactResult) -> Void) {
        let url = URL(string: "https://catfact.ninja/facts")!

        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard self != nil else { return }
            DispatchQueue.main.sync {
                do {
                    if let data = data,
                       let response = response as? HTTPURLResponse,
                       response.statusCode == 200 {
                        let response = try JSONDecoder().decode(RemoteCatFactResponse.self, from: data)
                        completion(.success(response.data))
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


