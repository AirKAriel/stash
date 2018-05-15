//
//  HomeNavigator.swift
//  ClientApp
//
//  Created by Jon Kimball on 6/2/17.
//  Copyright © 2017 GPShopper. All rights reserved.
//

import Foundation
import GDK

public protocol HomeNavigatable: ModuleNavigatable {
    
}

class HomeNavigator: HomeNavigatable {
    public var navController: UINavigationController!
    
    init(metadata: ModuleMetadata) {
        navController = HomeViewControllerFactory.makeHomeNavigationController(navigator: self)
        let viewController = navController.topViewController
        viewController?.title = metadata.title
    }
}
