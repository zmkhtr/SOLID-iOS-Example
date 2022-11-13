//
//  MovieItemMapper.swift
//  SOLID iOS Example
//
//  Created by Azam Mukhtar on 13/11/22.
//

import Foundation

class MovieItemMapper {
    
    static func map(_ data: Data, from response: HTTPURLResponse) throws -> [Movie] {
        guard response.statusCode == 200, let items = try? JSONDecoder().decode([RemoteMovie].self, from: data) else {
            throw NetworkError.invalidData
        }
        
        return items.toModels()
    }
}

private extension Array where Element == RemoteMovie {
    func toModels() -> [Movie] {
        return map { Movie(id: $0.id, title: $0.title, description: $0.description) }
    }
}
