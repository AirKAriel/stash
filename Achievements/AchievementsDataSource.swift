//
//  AchievementsDataSource.swift
//  Achievements
//
//  Created by Fangzhou Yan on 5/14/18.
//  Copyright © 2018 Fangzhou Yan. All rights reserved.
//

import Foundation
import UIKit

class AchievementsDataSource: NSObject, UITableViewDataSource {
    var achievements = [Achievement]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return achievements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "achievementsCell") as! AchievementsCell
        cell.configureWith(achievement: achievements[indexPath.row])
        return cell
    }
}
