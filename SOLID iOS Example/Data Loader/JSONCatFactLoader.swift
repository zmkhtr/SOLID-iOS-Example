//
//  JSONCatFactLoader.swift
//  SOLID iOS Example
//
//  Created by Azam Mukhtar on 22/01/23.
//

import Foundation

class JSONCatFactLoader: CatFactLoader {
    override func load(completion: @escaping (CatFactLoader.Result) -> Void) {
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
        }
    }
}
