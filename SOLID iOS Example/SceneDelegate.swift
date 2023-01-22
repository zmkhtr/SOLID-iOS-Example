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
        let client = URLSession.init(configuration: .ephemeral)
        let remote = RemoteCatFactLoader(url: url, client: client)
        
        // Remote Decorator
        let logRemoteDecorator = CatFactLoaderLogDecorator(decoratee: remote)
        let cacheRemoteDecorator = CatFactLoaderCacheDecorator(decoratee: logRemoteDecorator)
        
        // JSON
        let jsonLoader = JSONCatFactLoader()
        
        // Loader
        let loader = CatFactLoaderFallbackComposite(
            primary: jsonLoader,
            fallback: cacheRemoteDecorator)
        
        window?.rootViewController = makeCatFactsListViewController(with: loader)
        window?.makeKeyAndVisible()
    }
    
    
    private func makeCatFactsListViewController(with loader: CatFactLoader) -> CatFactListViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let catFactViewController = storyboard.instantiateInitialViewController { coder in
            return CatFactListViewController(coder: coder, loader: loader)
        }
        return catFactViewController!
    }
}

