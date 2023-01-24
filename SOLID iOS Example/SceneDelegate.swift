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
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
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
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController { coder in
            return CatFactListViewController(coder: coder, loader: loader)
        }
        
        
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }

}

