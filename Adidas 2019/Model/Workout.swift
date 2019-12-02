//
//  Workout.swift
//  Adidas 2019
//
//  Created by Bruno on 30/11/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import Foundation
import HealthKit

struct Workout {
    var start: Date
    var end: Date
    var intervals: [WorkoutInterval]
//    var activityType: HKWorkoutActivityType
    
    init(with intervals: [WorkoutInterval]/*, activityType: HKWorkoutActivityType*/) {
        self.start = intervals.first!.start
        self.end = intervals.last!.end
        self.intervals = intervals
//        self.activityType = activityType
    }
    
    var totalEnergyBurned: Double {
        return intervals.reduce(0) { (result, interval) in
            result + interval.totalEnergyBurned
        }
    }
    
    var duration: TimeInterval {
        return intervals.reduce(0) { (result, interval) in
            result + interval.duration
        }
    }
}
