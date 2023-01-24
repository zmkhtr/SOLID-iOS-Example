//
//  MovieLoader.swift
//  SOLID iOS Example
//
//  Created by Azam Mukhtar on 12/11/22.
//

import Foundation

class CatFactLoader {
    typealias Result = Swift.Result<[CatFactItem], Error>
    
    func load(completion: @escaping (Result) -> Void) {}
}
