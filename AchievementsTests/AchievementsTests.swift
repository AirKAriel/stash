//
//  AchievementsTests.swift
//  AchievementsTests
//
//  Created by Fangzhou Yan on 5/14/18.
//  Copyright © 2018 Fangzhou Yan. All rights reserved.
//

import XCTest
@testable import Achievements

class AchievementsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testValidAchievement() {
        let testDictionary: [String: Any] = ["id": 3,
                              "level": "2",
                              "progress": 0,
                              "total": 50,
                              "bg_image_url": "https://cdn.zeplin.io/5a5f7e1b4f9f24b874e0f19f/screens/341E40C8-1C2A-400C-B67D-F490B74BDD81.png",
                              "accessible": false]
        
        let achievement = Achievement(dictionary: testDictionary)
        XCTAssertEqual(achievement.id, 3)
        XCTAssertEqual(achievement.level, "2")
        XCTAssertEqual(achievement.progress, 0)
        XCTAssertEqual(achievement.total, 50)
        XCTAssertEqual(achievement.imageUrl, "https://cdn.zeplin.io/5a5f7e1b4f9f24b874e0f19f/screens/341E40C8-1C2A-400C-B67D-F490B74BDD81.png")
        XCTAssertEqual(achievement.accessible, false)
    }
    
    func testEmptyAchievement() {
        let testDictionary = [String: Any]()
        
        let achievement = Achievement(dictionary: testDictionary)
        XCTAssertEqual(achievement.id, 0)
        XCTAssertEqual(achievement.level, "")
        XCTAssertEqual(achievement.progress, 0)
        XCTAssertEqual(achievement.total, 0)
        XCTAssertEqual(achievement.imageUrl, "")
        XCTAssertEqual(achievement.accessible, false)
    }
    
    func testValidAchievementResponse() {
        let testDictionary: [String: Any] = ["success": true,
                                             "status": 200,
                                             "overview": [
                                                "title": "Smart Investing"
            ],
                                             "achievements": [
                                                [
                                                    "id": 4,
                                                    "level": "1",
                                                    "progress": 10,
                                                    "total": 50,
                                                    "bg_image_url": "https://cdn.zeplin.io/5a5f7e1b4f9f24b874e0f19f/screens/C850B103-B8C5-4518-8631-168BB42FFBBD.png",
                                                    "accessible": true
                                                ]
            ]]
        
        let achievementResponse = AchievementResponse(dictionary: testDictionary)
        XCTAssertEqual(achievementResponse.status, 200)
        XCTAssertEqual(achievementResponse.success, true)
        XCTAssertEqual(achievementResponse.title, "Smart Investing")
        XCTAssertEqual(achievementResponse.achievments.count, 1)
    }
    
    func testEmptyAchievementResponse() {
        let testDictionary = [String: Any]()
        
        let achievementResponse = AchievementResponse(dictionary: testDictionary)
        XCTAssertEqual(achievementResponse.status, 0)
        XCTAssertEqual(achievementResponse.success, false)
        XCTAssertEqual(achievementResponse.title, "")
        XCTAssertEqual(achievementResponse.achievments.count, 0)
    }
    
    func testInteractor() {
        let testPresenter = MockedAchievementsPresenter()
        let testInteractor = AchievementsInteractor()
        testInteractor.presenter = testPresenter
        testInteractor.fetchAchievements()
        XCTAssertNotNil(testPresenter.response)
        XCTAssertEqual(testPresenter.response?.success, true)
        XCTAssertEqual(testPresenter.response?.status, 200)
        XCTAssertNotEqual(testPresenter.response?.title, "")
        XCTAssertNotEqual(testPresenter.response?.achievments.count, 0)
    }
}
