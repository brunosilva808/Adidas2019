//
//  GoalManagerTests.swift
//  Adidas 2019Tests
//
//  Created by Bruno on 03/12/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import XCTest
@testable import Adidas_2019

class GoalManagerTests: XCTestCase {
    
    var goalManager: GoalsManager!
    var goals: [Goal]!
    
    override func setUp() {
        super.setUp()
        
        goalManager = GoalsManager()
        let reward = Reward(trophy: "trophy", points: 5)
        goals = [Goal(id: "1", title: "title",
                      itemDescription: "itemDescription",
                      type: Type.runningDistance,
                      goal: 100,
                      reward: reward),
                 Goal(id: "2", title: "title",
                      itemDescription: "itemDescription",
                      type: Type.step,
                      goal: 100,
                      reward: reward)]
        
        goalManager.setGoals(goals: goals)
    }
    
    override func tearDown() {
        goalManager = nil
        super.tearDown()
    }
    
    func testMedals_WonRunning_WithSucces() {
        // Arrange
        let distanceWalkingRunning = 1000.0
        let pointsWon = 5
        let medalsWon = 1
        
        // Act
        goalManager.setDistanceWalkingRunning(distanceWalkingRunning: distanceWalkingRunning)
            
        // Assert
        XCTAssertEqual(goalManager.getDistanceWalkingRunningMedals().count, medalsWon, "Distance WalkingRunning  medals is not equal")
        XCTAssertEqual(goalManager.getDistanceWalkingRunningPoints(), pointsWon, "Distance WalkingRunning points is not equal")
        XCTAssertEqual(goalManager.getTotalMedals(), medalsWon, "Distance WalkingRunning total medals won is not equal")
    }
    
    func testGoal_WasMeet_WithSucces() {
        // Arrange
        let distanceWalkingRunning = 1000.0
        var check = false
        
        // Act
        goalManager.setDistanceWalkingRunning(distanceWalkingRunning: distanceWalkingRunning)

        if let goal = goals.first {
            check = goalManager.checkIfGoalWasMeet(goal: goal)
        }
        
        // Assert
        XCTAssertTrue(check, "Goal was not meet")
    }
    
    func testGoal_WasMeet_Fail() {
        // Arrange
        let distanceWalkingRunning = 10.0
        var check = false
        
        // Act
        goalManager.setDistanceWalkingRunning(distanceWalkingRunning: distanceWalkingRunning)
        
        if let goal = goals.first {
            check = goalManager.checkIfGoalWasMeet(goal: goal)
        }
        
        // Assert
        XCTAssertFalse(check, "Goal was meet")
    }
    
}
