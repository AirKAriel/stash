//
//  AchievementsInteractor.swift
//  Achievements
//
//  Created by Fangzhou Yan on 5/14/18.
//  Copyright © 2018 Fangzhou Yan. All rights reserved.
//

import Foundation

protocol AchievementsPresenterToInteractorProtocol: class {
    func fetchAchievements()
}

class AchievementsInteractor: AchievementsPresenterToInteractorProtocol {
    weak var presenter: AchievementsInteractorToPresenterProtocol?
    
    func fetchAchievements() {//using local json, can replace with webservice call.
        guard let jsonPath = Bundle.main.path(forResource: "achievements", ofType: "json") else {
            presenter?.failedToFetchAchievements()
            return
        }
        
        let url = URL(fileURLWithPath: jsonPath)
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
            
            if let json = json {
                presenter?.fetchedAchievements(response: AchievementResponse(dictionary: json))
            } else {
                presenter?.failedToFetchAchievements()
            }
        } catch {
            presenter?.failedToFetchAchievements()
        }
    }
}
