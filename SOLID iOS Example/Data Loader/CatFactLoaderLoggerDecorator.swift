//
//  CatFactLoaderLoggerDecorator.swift
//  SOLID iOS Example
//
//  Created by Azam Mukhtar on 24/01/23.
//

import Foundation

class CatFactLoaderLoggerDecorator: CatFactLoader {
    private let decoratee: CatFactLoader
    
    init(decoratee: CatFactLoader) {
        self.decoratee = decoratee
    }
    
    func load(completion: @escaping (CatFactLoader.Result) -> Void) {
        decoratee.load { result in
            print("RESULT : \(result)")
        }
    }
}
