//
//  JSONCatFactLoader.swift
//  SOLID iOS Example
//
//  Created by Azam Mukhtar on 22/01/23.
//

import Foundation

class JSONCatFactLoader: CatFactLoader {
    override func load(completion: @escaping (CatFactLoader.Result) -> Void) {
        guard let url = Bundle.main.url(forResource: "CatFacts", withExtension: "json") else {
            completion(.failure(GeneralError.missingJSONFile))
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(RemoteCatFactResponse.self, from: data)
            let catFacts = jsonData.data.map { remoteFact in
                CatFactItem(fact: remoteFact.fact)
            }
            completion(.success(catFacts))
        } catch {
            completion(.failure(GeneralError.unexpectedData))
        }
    }
}
