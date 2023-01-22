//
//  RemoteCatFactLoader.swift
//  SOLID iOS Example
//
//  Created by Azam Mukhtar on 22/01/23.
//

import Foundation

class RemoteCatFactLoader: CatFactLoader {
    
    private let url: URL
    private let client: URLSession
    
    typealias Result = Swift.Result<[CatFactItem], Error>
    
    init(url: URL, client: URLSession) {
        self.url = url
        self.client = client
    }
    
    override func load(completion: @escaping (Result) -> Void) {
        client.dataTask(with: url) { [weak self] (data, response, error) in
            guard self != nil else { return }
            if let data = data,
               let response = response as? HTTPURLResponse {
                completion(RemoteCatFactLoader.map(data, response))
            } else {
                completion(.failure(NetworkError.networkError))
            }
        }.resume()
    }
    
    private static func map(_ data: Data, _ response: HTTPURLResponse) -> Result {
        do {
            let facts = try CatFactsItemMapper.map(data, from: response)
            return .success(facts)
        } catch {
            return .failure(NetworkError.unexpectedData)
        }
    }
}
