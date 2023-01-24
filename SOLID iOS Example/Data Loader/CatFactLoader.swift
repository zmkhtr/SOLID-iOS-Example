//
//  MovieLoader.swift
//  SOLID iOS Example
//
//  Created by Azam Mukhtar on 12/11/22.
//

import Foundation

class CatFactLoader {
    
    private let url: URL
    private let session: URLSession
    
    init(url: URL, session: URLSession) {
        self.url = url
        self.session = session
    }
    
    typealias Result = Swift.Result<[CatFactItem], Error>
    
    
    func load(completion: @escaping (Result) -> Void) {
        session.dataTask(with: url) { [weak self] (data, response, error) in
            guard self != nil else { return }
            if let data = data,
               let response = response as? HTTPURLResponse {
                completion(CatFactLoader.map(data, response))
            } else {
                completion(.failure(NetworkError.networkError))
            }
        }.resume()
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
