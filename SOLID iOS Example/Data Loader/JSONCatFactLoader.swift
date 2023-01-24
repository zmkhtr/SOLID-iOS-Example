//
//  JSONCatFactLoader.swift
//  SOLID iOS Example
//
//  Created by Azam Mukhtar on 24/01/23.
//

import Foundation

class JSONCatFactLoader: CatFactLoader {
    func load(completion: @escaping (CatFactLoader.Result) -> Void) {
        if let url = Bundle.main.url(forResource: "CatFacts", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(RemoteCatFactResponse.self, from: data)
                let catFacts = jsonData.data.map { remoteFact in
                    CatFactItem(fact: remoteFact.fact)
                }
                completion(.success(catFacts))
            } catch {
                completion(.failure(NetworkError.unexpectedData))
            }
        } else {
            completion(.failure(NetworkError.unexpectedData))
        }
    }
}
