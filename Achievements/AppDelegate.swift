//
//  AppDelegate.swift
//  Achievements
//
//  Created by Fangzhou Yan on 5/14/18.
//  Copyright © 2018 Fangzhou Yan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        configureAppearance()
        configureRootViewController()

        return true
    }

    func configureAppearance() {
        UINavigationBar.appearance().barTintColor = UIColor.purple 
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        UINavigationBar.appearance().barStyle = .blackOpaque
    }
    
    func configureRootViewController() {
        let achievementsViewController = AchievementsViewControllerFactory().makeAchievementsNavigationController()
        window?.rootViewController = achievementsViewController
        window?.makeKeyAndVisible()
    }
}

