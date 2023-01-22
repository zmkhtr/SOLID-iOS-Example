//
//  RemoteCatFactLoader.swift
//  SOLID iOS Example
//
//  Created by Azam Mukhtar on 22/01/23.
//

import Foundation

class RemoteCatFactLoader: CatFactLoader {
    
    private let url: URL
    private let client: HTTPClient
    
    typealias Result = Swift.Result<[CatFactItem], Error>
    
    init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    func load(completion: @escaping (Result) -> Void) {
        client.request(from: url) { result in
            switch result {
            case let .success((data, response)):
                completion(RemoteCatFactLoader.map(data, response))
            case .failure:
                completion(.failure(GeneralError.networkError))
            }
        }
    }
    
    private static func map(_ data: Data, _ response: HTTPURLResponse) -> Result {
        do {
            let facts = try CatFactsItemMapper.map(data, from: response)
            return .success(facts)
        } catch {
            return .failure(GeneralError.unexpectedData)
        }
    }
}
