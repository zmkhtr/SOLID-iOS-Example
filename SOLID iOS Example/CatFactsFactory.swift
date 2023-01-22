//
//  CatFactsFactory.swift
//  SOLID iOS Example
//
//  Created by Azam Mukhtar on 22/01/23.
//

import Foundation

class CatFactsFactory {
    private init () {}
    
    static func create() -> CatFactListViewController {
        // Remote
        let url = URL(string: "https://catfact.ninja/facts")!
        let session = URLSession.init(configuration: .ephemeral)
        _ = URLSessionHTTPClient(session: session)
        // let remote = RemoteCatFactLoader(url: url, client: client)
        let remote = RemoteCatFactLoader(url: url, client: AlamofireHTTPClient())
        
        // Remote Decorator
        let logRemoteDecorator = CatFactLoaderLogDecorator(decoratee: remote)
        let cacheRemoteDecorator = CatFactLoaderCacheDecorator(decoratee: logRemoteDecorator)
        
        // JSON
        let jsonLoader = JSONCatFactLoader()
        
        // Loader
        let loader = CatFactLoaderFallbackComposite(
            primary: cacheRemoteDecorator,
            fallback: jsonLoader)
        
        return CatFactsUIComposer.catFactsComposedWith(loader: loader)
    }
}
