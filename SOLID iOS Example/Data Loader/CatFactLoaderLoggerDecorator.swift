//
//  CatFactLoaderLoggerDecorator.swift
//  SOLID iOS Example
//
//  Created by Azam Mukhtar on 24/01/23.
//

import Foundation

class CatFactLoaderLoggerDecorator: CatFactLoader {
    
    override func load(completion: @escaping (CatFactLoader.Result) -> Void) {
        super.load { result in
            print("RESULT : \(result)")
        }
    }
}
