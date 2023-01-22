//
//  CatFactsItemMapper.swift
//  SOLID iOS Example
//
//  Created by Azam Mukhtar on 22/01/23.
//

import Foundation

class CatFactsItemMapper {

    static func map(_ data: Data, from response: HTTPURLResponse) throws -> [CatFactItem] {
        guard response.statusCode == 200, let items = try? JSONDecoder().decode(RemoteCatFactResponse.self, from: data) else {
            throw NetworkError.unexpectedData
        }

        let catFacts = items.data.map { remoteFact in
            CatFactItem(fact: remoteFact.fact)
        }
        return catFacts
    }
}
