//
//  SceneDelegate.swift
//  SOLID iOS Example
//
//  Created by Azam Mukhtar on 12/11/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)

        // Remote
        let url = URL(string: "https://catfact.ninja/facts")!
        let session = URLSession.init(configuration: .ephemeral)
        _ = URLSessionHTTPClient(session: session)
//        let remote = RemoteCatFactLoader(url: url, client: client)
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
        
        window?.rootViewController = CatFactsUIComposer.catFactsComposedWith(loader: loader)
        window?.makeKeyAndVisible()
    }
}

