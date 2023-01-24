//
//  RemoteCatFactLoader.swift
//  SOLID iOS Example
//
//  Created by Azam Mukhtar on 24/01/23.
//

import Foundation

class RemoteCatFactLoader: CatFactLoader {
    
    private let url: URL
    private let client: HTTPClient
    
    init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    typealias Result = CatFactLoader.Result
    
    
    func load(completion: @escaping (Result) -> Void) {
        client.request(from: url) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case let .success((data, response)):
                completion(RemoteCatFactLoader.map(data, response))
            case .failure:
                completion(.failure(NetworkError.networkError))
            }
        }
    }
    
    private static func map(_ data: Data, _ response: HTTPURLResponse) -> Result {
        do {
            let facts = try CatFactItemMapper.map(data, from: response)
            return .success(facts)
        } catch {
            return .failure(NetworkError.unexpectedData)
        }
    }
}
