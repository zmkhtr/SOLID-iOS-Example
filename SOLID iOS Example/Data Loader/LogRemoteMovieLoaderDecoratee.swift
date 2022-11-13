//
//  LogRemoteMovieLoaderDecoratee.swift
//  SOLID iOS Example
//
//  Created by Azam Mukhtar on 13/11/22.
//

import Foundation

class LogRemoteMovieLoaderDecoratee: MovieLoader {
    
    private let decoratee: RemoteMovieLoader
    
    init(decoratee: RemoteMovieLoader) {
        self.decoratee = decoratee
    }
    
    override func getMovieList(completion: @escaping (MovieLoader.Result) -> Void) {
        decoratee.getMovieList { result in
            switch result {
            case let .success(movies):
                print("Log Movies \(movies)")
                completion(.success(movies))
            case let .failure(error):
                print("Log Error \(error)")
                completion(.failure(error))
            }
        }
    }
}
