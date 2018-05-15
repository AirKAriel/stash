//
//  AchievementsViewController.swift
//  Achievements
//
//  Created by Fangzhou Yan on 5/14/18.
//  Copyright © 2018 Fangzhou Yan. All rights reserved.
//

import UIKit

protocol AchievementsPresenterToViewControllerProtocol: class {
    func fetchedAchievements(response: AchievementResponse)
    func failedToFetchAchievements()
}

class AchievementsViewController: UIViewController, AchievementsPresenterToViewControllerProtocol {
    @IBOutlet weak var tableView: UITableView!
  
    var presenter: AchievementsViewControllerToPresenterProtocol?
    var dataSource = AchievementsDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.fetchAchievements()
        tableView.dataSource = dataSource
    }

    func fetchedAchievements(response: AchievementResponse) {
        self.title = response.title
        dataSource.achievements = response.achievments
        tableView.reloadData()
    }
    
    func failedToFetchAchievements() {
        //show some error message
    }
}

