//
//  MedalsManager.swift
//  Adidas 2019
//
//  Created by Bruno on 02/12/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import Foundation

final class GoalsManager {
    private var steps: Double?
    private var distanceWalkingRunning: Double?
    private var goals: [Goal]?
    
    func setGoals(goals: [Goal]) {
        self.goals = goals
    }
    
    func setSteps(steps: Double) {
        self.steps = steps
    }
    
    func setDistanceWalkingRunning(distanceWalkingRunning: Double) {
        self.distanceWalkingRunning = distanceWalkingRunning
    }
    
    func getStepMedals() -> [Goal] {
        
        guard let goals = goals, let steps = steps else {
            return []
        }
        
        let medals: [Goal] = goals.filter {
            return Int(steps) > $0.goal && $0.type == .step
        }
        
        return medals
    }
    
    func getDistanceWalkingRunningMedals() -> [Goal] {
        
        guard let goals = goals, let distanceWalkingRunning = distanceWalkingRunning else {
            return []
        }
        
        let medals: [Goal] = goals.filter {
            return Int(distanceWalkingRunning) > $0.goal && ( $0.type == .runningDistance || $0.type == .walkingDistance)
        }
        
        return medals
    }
    
    func getTotalMedals() -> Int {
        return getStepMedals().count + getDistanceWalkingRunningMedals().count
    }
    
    func getStepPoints() -> Int {
        
        guard let goals = goals, let steps = steps else {
            return 0
        }
        
        let points: [Goal] = goals.filter {
            Int(steps) > $0.goal && $0.type == .step
        }
        
        return points.reduce(0) { $0 + $1.reward.points }
    }
    
    func getDistanceWalkingRunningPoints() -> Int {
        
        guard let goals = goals, let distanceWalkingRunning = distanceWalkingRunning else {
            return 0
        }
        
        let points: [Goal] = goals.filter {
            Int(distanceWalkingRunning) > $0.goal && ( $0.type == .runningDistance || $0.type == .walkingDistance)
        }
        
        return points.reduce(0) { $0 + $1.reward.points }
    }
    
    func getTotalPoints() -> Int {
        return getStepPoints() + getDistanceWalkingRunningPoints()
    }
    
    func checkIfGoalWasMeet(goal: Goal) -> Bool {
        if  goal.type == .step,
            let steps = steps,
            Int(steps) > goal.goal  {
            
            return true
        } else if (goal.type == .runningDistance || goal.type == .runningDistance),
                  let distanceWalkingRunning = distanceWalkingRunning,
                  Int(distanceWalkingRunning) > goal.goal {
            
            return true
        }
        
        return false
    }
}
