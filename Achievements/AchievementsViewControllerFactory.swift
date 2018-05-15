//
//  AchievementsViewControllerFactory.swift
//  Achievements
//
//  Created by Fangzhou Yan on 5/14/18.
//  Copyright © 2018 Fangzhou Yan. All rights reserved.
//

import Foundation
import UIKit

struct AchievementsViewControllerFactory {
    var storyboard: UIStoryboard {
        return UIStoryboard(name: "Achievements", bundle: Bundle.main)
    }
    
    func makeAchievementsNavigationController() -> UINavigationController {
        let nav = storyboard.instantiateInitialViewController() as! UINavigationController
        let vc = nav.topViewController as! AchievementsViewController
        let router = AchievementsRouter(viewController: vc)
        let interactor = AchievementsInteractor()
        let presenter = AchievementsPresenter(viewController: vc, interactor: interactor, router: router)
        interactor.presenter = presenter
        vc.presenter = presenter
        
        return nav
    }
}
