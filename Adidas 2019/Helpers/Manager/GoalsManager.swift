//
//  MedalsManager.swift
//  Adidas 2019
//
//  Created by Bruno on 02/12/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import Foundation

final class GoalsManager {
    private var distance: Double?
    private var goals: [Goal]?
    
    func setGoals(goals: [Goal]) {
        self.goals = goals
    }
    
    func setDistance(distance: Double) {
        self.distance = distance
    }
    
    func getMedals() -> [Goal] {
        
        guard let goals = goals, let distance = distance else {
            return []
        }
        
        let medals: [Goal] = goals.filter {
            Int(distance) > $0.goal && $0.type == .step
        }
        
        return medals
    }
    
    func getPoints() -> Int {
        
        guard let goals = goals, let distance = distance else {
            return 0
        }
        
        let points: [Goal] = goals.filter {
            Int(distance) > $0.goal && $0.type == .step
        }
        
        return points.reduce(0) { $0 + $1.reward.points }
    }
}
