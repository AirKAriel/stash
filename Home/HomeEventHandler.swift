//
//  HomeEventHandler.swift
//  ClientCore
//
//  Created by Fangzhou Yan on 12/5/17.
//  Copyright © 2017 GPshopper. All rights reserved.
//

import Foundation
import GDK

struct HomeEventHandler {
    unowned let viewController: HomeViewController
    fileprivate let navigator: HomeNavigatable
    
    public init(viewController: HomeViewController, navigator: HomeNavigatable) {
        self.viewController = viewController
        self.navigator = navigator
    }
    
    func presentSearchViewController() {
        self.navigator.pushSearchViewController(viewController: viewController)
    }
    
    func pushProductListViewController(searchQuery: String) {
        self.navigator.pushProductListViewController(searchQuery: searchQuery)
    }
}
