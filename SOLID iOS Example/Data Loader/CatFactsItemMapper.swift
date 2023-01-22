//
//  CatFactsItemMapper.swift
//  SOLID iOS Example
//
//  Created by Azam Mukhtar on 22/01/23.
//

import Foundation

class CatFactsItemMapper {

    static func map(_ data: Data, from response: HTTPURLResponse) throws -> [RemoteCatFact] {
        guard response.statusCode == 200, let items = try? JSONDecoder().decode(RemoteCatFactResponse.self, from: data) else {
            throw NetworkError.unexpectedData
        }

        return items.data
    }
}
