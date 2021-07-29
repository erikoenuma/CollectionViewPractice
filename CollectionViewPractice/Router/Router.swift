//
//  Router.swift
//  CollectionViewPractice
//
//  Created by 肥沼英里 on 2021/05/27.
//

import Foundation
import UIKit

final class Router{
    static let shared = Router()
    private init() {}
    
    private var window: UIWindow?
    
    func showRoot(window: UIWindow){
        guard let vc = UIStoryboard.init(name: "CompositionalLayoutView", bundle: nil).instantiateInitialViewController() as? CompositionalLayoutViewController
        else { return }
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
        self.window = window
    }
}
