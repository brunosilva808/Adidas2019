//
//  WorkoutService.swift
//  Adidas 2019
//
//  Created by Bruno on 03/12/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import Foundation
import HealthKit

final class WorkoutService {
    
    private var workoutDataStore: WorkoutDataStore!
    private var workoutSession: WorkoutSession!
    
    init(workoutDataStore: WorkoutDataStore, workoutSession: WorkoutSession) {
        self.workoutSession = workoutSession
        self.workoutDataStore = workoutDataStore
    }
    
    func startWorkout() {
        workoutSession.start()
    }
    
    func workoutStartDate() -> Date {
        return workoutSession.startDate
    }
    
    func endWorkout() {
        workoutSession.end()
    }
    
    func workoutEndDate() -> Date {
        return workoutSession.endDate
    }
    
    func workoutState() -> WorkoutSessionState {
        return workoutSession.state
    }
    
    func saveWorkout(onSuccess: @escaping () -> Void, onFailure: @escaping () -> Void) {
        guard let workoutComplete = workoutSession.completeWorkout else {
            return
        }
        
        workoutDataStore.save(workout: workoutComplete) { (response, error) in
            DispatchQueue.main.async {
                if response {
                    onSuccess()
                } else {
                    onFailure()
                }
            }
        }
    }
    
    func loadWorkout(onSuccess: @escaping ([HKWorkout]?) -> Void, onFailure: @escaping (Error?) -> Void) {
        workoutDataStore.load() { (workouts, error) in
            
            guard let workouts = workouts else {
                onFailure(error)
                return
            }
                
            onSuccess(workouts)
        }
    }
    
    func clearSession() {
        workoutSession.clear()
    }
}
