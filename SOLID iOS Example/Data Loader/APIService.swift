//
//  MovieLoader.swift
//  SOLID iOS Example
//
//  Created by Azam Mukhtar on 12/11/22.
//

import Foundation

class APIService {
    
    private let url: URL
    private let client: URLSession
    
    typealias Result = Swift.Result<[RemoteCatFact], Error>
    
    init(url: URL, client: URLSession) {
        self.url = url
        self.client = client
    }
    
    func getCatFacts(completion: @escaping (Result) -> Void) {
        client.dataTask(with: url) { [weak self] (data, response, error) in
            guard self != nil else { return }
            DispatchQueue.main.sync {
                if let data = data,
                   let response = response as? HTTPURLResponse {
                    do {
                        let facts = try CatFactsItemMapper.map(data, from: response)
                        completion(.success(facts))
                    } catch {
                        completion(.failure(NetworkError.unexpectedData))
                    }
                } else {
                    completion(.failure(NetworkError.networkError))
                }
            }
        }.resume()
    }
}


