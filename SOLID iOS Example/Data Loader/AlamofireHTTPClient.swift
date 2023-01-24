//
//  AlamofireHTTPClient.swift
//  SOLID iOS Example
//
//  Created by Azam Mukhtar on 24/01/23.
//

import Foundation
import Alamofire

class AlamofireHTTPClient: HTTPClient {
    func request(from url: URL, completion: @escaping (HTTPClient.Result) -> Void) {
        AF.request(url).response { response in
            if let error = response.error {
                completion(.failure(error))
            } else if let data = response.data, let response = response.response {
                completion(.success((data, response)))
            } else {
                completion(.failure(NetworkError.unexpectedData))
            }
        }
    }
}
