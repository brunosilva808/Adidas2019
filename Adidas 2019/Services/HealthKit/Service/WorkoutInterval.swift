//
//  Workout.swift
//  Adidas 2019
//
//  Created by Bruno on 29/11/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import Foundation
import HealthKit

struct WorkoutInterval {
    var start: Date
    var end: Date
    
    var duration: TimeInterval {
        return end.timeIntervalSince(start)
    }
    
    var totalEnergyBurned: Double {
        let prancerciseCaloriesPerHour: Double = 450
        let hours: Double = duration / 3600
        let totalCalories = prancerciseCaloriesPerHour * hours
        return totalCalories
    }
}
