//
//  CatFactsUIComposer.swift
//  SOLID iOS Example
//
//  Created by Azam Mukhtar on 22/01/23.
//

import Foundation
import UIKit

final class CatFactsUIComposer {
    private init() {}
    
    static func catFactsComposedWith(loader: CatFactLoader) -> CatFactListViewController {
        return CatFactsUIComposer.makeCatFactsListViewController(with: loader)
    }
    
    private static func makeCatFactsListViewController(with loader: CatFactLoader) -> CatFactListViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let catFactViewController = storyboard.instantiateInitialViewController { coder in
            return CatFactListViewController(coder: coder, loader: loader)
        }
        return catFactViewController!
    }
}
