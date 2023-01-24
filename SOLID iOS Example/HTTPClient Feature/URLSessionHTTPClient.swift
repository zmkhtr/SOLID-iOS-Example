//
//  URLSessionHTTPClient.swift
//  SOLID iOS Example
//
//  Created by Azam Mukhtar on 24/01/23.
//

import Foundation

class URLSessionHTTPClient: HTTPClient {
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func request(from url: URL, completion: @escaping (HTTPClient.Result) -> Void)  {
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data, let response = response as? HTTPURLResponse {
                completion(.success((data, response)))
            } else {
                completion(.failure(GeneralError.unexpectedData))
            }
        }.resume()
    }
}

