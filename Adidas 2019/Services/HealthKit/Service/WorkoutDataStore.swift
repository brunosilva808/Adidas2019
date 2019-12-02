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
            
            guard let quantityType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned) else {
                completion(false, nil)
                return
            }
            
            let unit = HKUnit.kilocalorie()
            let totalEnergyBurned = workout.totalEnergyBurned
            let quantity = HKQuantity(unit: unit, doubleValue: totalEnergyBurned)
            
            let sample = HKCumulativeQuantitySeriesSample(type: quantityType,
                                                          quantity: quantity,
                                                          start: workout.start,
                                                          end: workout.end)
            
            //1. Add the sample to the workout builder
            builder.add([sample]) { (success, error) in
                guard success else {
                    completion(false, error)
                    return
                }
                
                //2. Finish collection workout data and set the workout end date
                //I should probably use an id
                builder.endCollection(withEnd: workout.end) { (success, error) in
                    guard success else {
                        completion(false, error)
                        return
                    }
                    
                    //3. Create the workout with the samples added
                    builder.finishWorkout { (_, error) in
                        let success = error == nil
                        completion(success, error)
                    }
                }
            }
        }
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
