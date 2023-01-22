//
//  CatFactLoaderLogDecorator.swift
//  SOLID iOS Example
//
//  Created by Azam Mukhtar on 22/01/23.
//

import Foundation

class CatFactLoaderLogDecorator: CatFactLoader {
    
    private let decoratee: CatFactLoader
    
    init(decoratee: CatFactLoader) {
        self.decoratee = decoratee
    }
    
    func load(completion: @escaping (CatFactLoader.Result) -> Void) {
        decoratee.load { result in
            print("CatFactLoader Result \(result)")
            completion(result)
        }
    }
}
