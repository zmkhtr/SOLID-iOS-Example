//
//  CatFactLoaderCacheDecorator.swift
//  SOLID iOS Example
//
//  Created by Azam Mukhtar on 24/01/23.
//

import Foundation

class CatFactLoaderCacheDecorator: CatFactLoader {
    private let decoratee: CatFactLoader
    
    init(decoratee: CatFactLoader) {
        self.decoratee = decoratee
    }
    
    func load(completion: @escaping (CatFactLoader.Result) -> Void) {
        decoratee.load { result in
            switch result {
            case let .success(facts):
                print("Data Saved \(facts)")
                completion(.success(facts))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
