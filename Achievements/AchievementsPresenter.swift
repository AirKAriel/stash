//
//  AchievementsPresenter.swift
//  Achievements
//
//  Created by Fangzhou Yan on 5/14/18.
//  Copyright © 2018 Fangzhou Yan. All rights reserved.
//

import Foundation

protocol AchievementsViewControllerToPresenterProtocol: class {
    func fetchAchievements()
}

protocol AchievementsInteractorToPresenterProtocol: class {
    func fetchedAchievements(response: AchievementResponse)
    func failedToFetchAchievements()
}

class AchievementsPresenter: AchievementsViewControllerToPresenterProtocol, AchievementsInteractorToPresenterProtocol {
    
    weak var viewController: AchievementsPresenterToViewControllerProtocol?
    var interactor: AchievementsPresenterToInteractorProtocol?
    var router: AchievementsPresenterToRouterProtocol?
    
    init(viewController: AchievementsPresenterToViewControllerProtocol?, interactor: AchievementsPresenterToInteractorProtocol?, router: AchievementsPresenterToRouterProtocol?) {
        self.viewController = viewController
        self.interactor = interactor
        self.router = router
    }
    
    func fetchAchievements() {
        interactor?.fetchAchievements()
    }
    
    func fetchedAchievements(response: AchievementResponse) {
        viewController?.fetchedAchievements(response: response)
    }
    
    func failedToFetchAchievements() {
        viewController?.failedToFetchAchievements()
    }
}
