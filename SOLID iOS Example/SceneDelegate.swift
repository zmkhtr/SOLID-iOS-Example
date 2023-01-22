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

        let url = URL(string: "https://catfact.ninja/facts")!
        let client = URLSession.init(configuration: .ephemeral)
        
        let loader = RemoteCatFactLoader(url: url, client: client)
        let jsonLoader = JSONCatFactLoader()
        let composite = CatFactLoaderFallbackComposite(
            primary: jsonLoader,
            fallback: loader)
        
        window?.rootViewController = makeCatFactsListViewController(with: composite)
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

