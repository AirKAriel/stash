//
//  HomeViewControllerFactory.swift
//  ClientApp
//
//  Created by Trace Pomplun on 10/18/16.
//  Copyright © 2016 GPShopper. All rights reserved.
//

import UIKit

struct HomeViewControllerFactory {
    
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: "Home", bundle: Bundle(for:AppEnvironment.self))
    }
    
    static func makeHomeNavigationController(navigator:HomeNavigatable) -> UINavigationController {
        let nav = storyboard.instantiateInitialViewController() as! UINavigationController
        let vc = nav.topViewController as! HomeViewController
        let eventHandler = HomeEventHandler(viewController: vc, navigator: navigator)
        vc.output = eventHandler
        return nav
    }
}
