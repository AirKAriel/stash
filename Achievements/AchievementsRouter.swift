//
//  AchievementsRouter.swift
//  Achievements
//
//  Created by Fangzhou Yan on 5/14/18.
//  Copyright © 2018 Fangzhou Yan. All rights reserved.
//

import Foundation

protocol AchievementsPresenterToRouterProtocol: class {
    func goToAchievementDetail(achievement: Achievement)
}

class AchievementsRouter: AchievementsPresenterToRouterProtocol {
    weak var viewController: AchievementsViewController?
    
    init(viewController: AchievementsViewController?) {
        self.viewController = viewController
    }
    
    func goToAchievementDetail(achievement: Achievement) {
        //Navigation is handled here, such as go to achievements detail
    }
}
