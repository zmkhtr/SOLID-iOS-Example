//
//  CatFactLoaderFallbackComposite.swift
//  SOLID iOS Example
//
//  Created by Azam Mukhtar on 24/01/23.
//

import Foundation

class CatFactLoaderFallbackComposite: CatFactLoader {

    private let primary: CatFactLoader
    private let fallback: CatFactLoader
    
    init(primary: CatFactLoader, fallback: CatFactLoader) {
        self.primary = primary
        self.fallback = fallback
    }
    
    
    func load(completion: @escaping (CatFactLoader.Result) -> Void) {
        primary.load { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(facts):
                completion(.success(facts))
            case .failure:
                self.fallback.load(completion: completion)
            }
        }
    }
}
