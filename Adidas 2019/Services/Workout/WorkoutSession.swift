//
//  WorkoutSession.swift
//  Adidas 2019
//
//  Created by Bruno on 02/12/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import Foundation

enum WorkoutSessionState {
    case notStarted
    case active
    case finished
}

class WorkoutSession {
    private (set) var startDate: Date!
    private (set) var endDate: Date!
    
    var intervals: [WorkoutInterval] = []
    var state: WorkoutSessionState = .notStarted
    
    var completeWorkout: Workout? {
        guard state == .finished, intervals.count > 0 else {
            return nil
        }
        
        return Workout(with: intervals)
    }
    
    func clear() {
        startDate = nil
        endDate = nil
        state = .notStarted
        intervals.removeAll()
    }
    
    func start() {
        startDate = Date()
        state = .active
    }
    
    func end() {
        endDate = Date()
        state = .finished
        
        addNewInterval()
    }
    
    func addNewInterval() {
        let worktouInterval = WorkoutInterval(start: startDate, end: endDate)
        intervals.append(worktouInterval)
    }
    
}
