//
//  HomeModule.swift
//  ClientCore
//
//  Created by Fangzhou Yan on 12/5/17.
//  Copyright © 2017 GPshopper. All rights reserved.
//

import Foundation

public class HomeModule: Module {
    
    public let useCase: Any?
    public let navigator: ModuleNavigatable
    public let metadata: ModuleMetadata
    
    public required init(metadata: ModuleMetadata, navigator: HomeNavigatable) {
        self.navigator = navigator
        self.useCase = nil
        self.metadata = metadata
        navigator.navController.tabBarItem = CoreTabBarItem(module: self)
    }
}
