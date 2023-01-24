//
//  CatFactsFactory.swift
//  SOLID iOS Example
//
//  Created by Azam Mukhtar on 24/01/23.
//

import Foundation

class CatFactsFactory {
    private init() {}
    
    static func create() -> CatFactListViewController {
        let url = URL(string: "https://catfact.ninja/facts")!
        let session = URLSession(configuration: .ephemeral)
//        let client = URLSessionHTTPClient(session: session)
        let client = AlamofireHTTPClient()
        let remote = RemoteCatFactLoader(url: url, client: client)
        let remoteCache = CatFactLoaderCacheDecorator(decoratee: remote)
        
        let json = JSONCatFactLoader()
        let jsonLog = CatFactLoaderCacheDecorator(decoratee: json)
        
        let loader = CatFactLoaderFallbackComposite(
            primary: remoteCache,
            fallback: jsonLog)
        
        return CatFactsUIComposer.catFactsComposedWith(loader: loader)
    }
}
