//
//  MockedPresenter.swift
//  AchievementsTests
//
//  Created by Fangzhou Yan on 5/14/18.
//  Copyright © 2018 Fangzhou Yan. All rights reserved.
//

import Foundation

class MockedAchievementsPresenter: AchievementsInteractorToPresenterProtocol {
    var response: AchievementResponse?
    
    func fetchedAchievements(response: AchievementResponse) {
        self.response = response
    }
    
    func failedToFetchAchievements() {
        
    }
}
