//
//  WorkoutDataStore.swift
//  Adidas 2019
//
//  Created by Bruno on 29/11/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import Foundation
import HealthKit

struct WorkoutDataStore {
    
    let healthStore: HKHealthStore!
    
    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }
    
    func save(workout: Workout, completion: @escaping ((Bool, Error?) -> Void)) {
        let workoutConfiguration = HKWorkoutConfiguration()
        workoutConfiguration.activityType = .running
        
        let builder = HKWorkoutBuilder(healthStore: healthStore,
                                       configuration: workoutConfiguration,
                                       device: .local())
        
        builder.beginCollection(withStart: workout.start) { (success, error) in

            guard success else {
                completion(false, error)
                return
            }
            
            let samples = self.samples(for: workout)
            
            builder.add(samples) { (success, error) in
                guard success else {
                    completion(false, error)
                    return
                }
                
                builder.endCollection(withEnd: workout.end) { (success, error) in
                    guard success else {
                        completion(false, error)
                        return
                    }
                    
                    builder.finishWorkout { (workout, error) in
                        let success = error == nil
                        completion(success, error)
                    }
                }
            }
        }
    }
    
    private func samples(for workout: Workout) -> [HKSample] {
        //1. Verify that the energy quantity type is still available to HealthKit.
        guard let energyQuantityType = HKSampleType.quantityType(
            forIdentifier: .activeEnergyBurned) else {
                fatalError("*** Energy Burned Type Not Available ***")
        }
        
        //2. Create a sample for each workoutInterval
        let samples: [HKSample] = workout.intervals.map { interval in
            let calorieQuantity = HKQuantity(unit: .kilocalorie(),
                                             doubleValue: interval.totalEnergyBurned)
            
            return HKCumulativeQuantitySeriesSample(type: energyQuantityType,
                                                    quantity: calorieQuantity,
                                                    start: interval.start,
                                                    end: interval.end)
        }
        
        return samples
    }
    
    func load(completion: @escaping ([HKWorkout]?, Error?) -> Void) {
        let workoutPredicate = HKQuery.predicateForWorkouts(with: .running)
        
        //2. Get all workouts that only came from this app.
        let sourcePredicate = HKQuery.predicateForObjects(from: .default())
        
        //3. Combine the predicates into a single predicate.
        let compound = NSCompoundPredicate(andPredicateWithSubpredicates:
            [workoutPredicate, sourcePredicate])
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate,
                                              ascending: true)
        let limit = 0

        let query = HKSampleQuery(
            sampleType: .workoutType(),
            predicate: compound,
            limit: limit,
            sortDescriptors: [sortDescriptor]) { (query, samples, error) in
                guard
                    let samples = samples as? [HKWorkout],
                    error == nil
                    else {
                        completion(nil, error)
                        return
                }
                
                completion(samples, nil)
        }
        
        HKHealthStore().execute(query)
    }
}
