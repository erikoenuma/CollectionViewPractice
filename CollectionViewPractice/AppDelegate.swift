//
//  AppDelegate.swift
//  CollectionViewPractice
//
//  Created by 肥沼英里 on 2021/05/27.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Router.shared.showRoot(window: UIWindow(frame: UIScreen.main.bounds))
        return true
    }

}
