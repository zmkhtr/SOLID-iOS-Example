//
//  MovieLoader.swift
//  SOLID iOS Example
//
//  Created by Azam Mukhtar on 12/11/22.
//

import Foundation

class MovieLoader {
    typealias Result = Swift.Result<[Movie], Error>
    
    func getMovieList(completion: @escaping (Result) -> Void) {}
}
