//
//  CatFactLoaderCacheDecorator.swift
//  SOLID iOS Example
//
//  Created by Azam Mukhtar on 22/01/23.
//

import Foundation

class CatFactLoaderCacheDecorator: CatFactLoader {
    
    override func load(completion: @escaping (CatFactLoader.Result) -> Void) {
        super.load { result in
            switch result {
            case let .success(facts):
                // Save to Local Storage
                print("CatFactLoader \(facts.count) items Saved to Local storage")
                completion(.success(facts))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
