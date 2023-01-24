//
//  CatFactItemMapper.swift
//  SOLID iOS Example
//
//  Created by Azam Mukhtar on 24/01/23.
//

import Foundation

class CatFactItemMapper {
    private init() {}
    
    static func map(_ data: Data, from response: HTTPURLResponse) throws -> [CatFactItem] {
        guard response.statusCode == 200, let items = try? JSONDecoder().decode(RemoteCatFactResponse.self, from: data) else {
            throw NetworkError.unexpectedData
        }
        
        let facts = items.data.map { remoteCatFact in
            CatFactItem(fact: remoteCatFact.fact)
        }
        
        return facts
    }
}
