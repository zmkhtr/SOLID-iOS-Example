//
//  CatFactLoaderLogDecorator.swift
//  SOLID iOS Example
//
//  Created by Azam Mukhtar on 22/01/23.
//

import Foundation

class CatFactLoaderLogDecorator: CatFactLoader {
    
    override func load(completion: @escaping (CatFactLoader.Result) -> Void) {
        super.load { result in
            print("CatFactLoader Result \(result)")
            completion(result)
        }
    }
}
