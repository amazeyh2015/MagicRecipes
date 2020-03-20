//
//  AppDelegate.swift
//  MagicRecipes
//
//  Created by 于涵 on 2019/11/2.
//  Copyright © 2019 yuhan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        ImageManager.shared.createDirectoryIfNeeded()
        
        let window = UIWindow()
        window.frame = UIScreen.main.bounds
        window.rootViewController = rootViewController()
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
    
    func rootViewController() -> UIViewController {
        let vc = RecipeListViewController()
        let nc = UINavigationController(rootViewController: vc)
        return nc
    }
}

