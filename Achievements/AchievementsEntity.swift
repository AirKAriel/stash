//
//  AchievementsEntity.swift
//  Achievements
//
//  Created by Fangzhou Yan on 5/14/18.
//  Copyright © 2018 Fangzhou Yan. All rights reserved.
//

import Foundation

/*
 {
 "success": true,
 "status": 200,
 "overview": {
 "title": "Smart Investing"
 },
 "achievements": [
 {
 "id": 4,
 "level": "1",
 "progress": 10,
 "total": 50,
 "bg_image_url": "https://cdn.zeplin.io/5a5f7e1b4f9f24b874e0f19f/screens/C850B103-B8C5-4518-8631-168BB42FFBBD.png",
 "accessible": true
 },
 {
 "id": 3,
 "level": "2",
 "progress": 0,
 "total": 50,
 "bg_image_url": "https://cdn.zeplin.io/5a5f7e1b4f9f24b874e0f19f/screens/341E40C8-1C2A-400C-B67D-F490B74BDD81.png",
 "accessible": false
 },
 {
 "id": 5,
 "level": "3",
 "progress": 0,
 "total": 50,
 "bg_image_url": "https://cdn.zeplin.io/5a5f7e1b4f9f24b874e0f19f/screens/C60F6868-A0CD-4D9D-A3B9-3C460FA989FF.png",
 "accessible": false
 }
 ]
 }

 */

class AchievementResponse {
    var achievments: [Achievement]
    var title: String
    var status: NSNumber
    var success: Bool
    
    init (dictionary: [String: Any]) {
        if let achievementsArray = dictionary["achievements"] as? [[String: Any]] {
            achievments = achievementsArray.map({Achievement(dictionary: $0)})
        } else {
            achievments = [Achievement]()
        }
        
        if let overviewDict = dictionary["overview"] as? [String: Any] {
            title = overviewDict["title"] as? String ?? ""
        } else {
            title = ""
        }
        
        status = dictionary["status"] as? NSNumber ?? 0
        success = dictionary["success"] as? Bool ?? false
    }
}

class Achievement {
    var id: NSNumber
    var level: String
    var progress: NSNumber
    var total: NSNumber
    var imageUrl: String
    var accessible: Bool
    
    init(dictionary: [String: Any]) {
        id = dictionary["id"] as? NSNumber ?? 0
        level = dictionary["level"] as? String ?? ""
        progress = dictionary["progress"] as? NSNumber ?? 0
        total = dictionary["total"] as? NSNumber ?? 0
        imageUrl = dictionary["bg_image_url"] as? String ?? ""
        accessible = dictionary["accessible"] as? Bool ?? false
    }
}
