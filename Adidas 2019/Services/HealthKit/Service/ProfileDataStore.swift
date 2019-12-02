//
//  ProfileDataStore.swift
//  Adidas 2019
//
//  Created by Bruno on 27/11/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import HealthKit

struct ProfileDataStore {
    
    private let healthKitStore: HKHealthStore!
    
    init(healthKitStore: HKHealthStore) {
        self.healthKitStore = healthKitStore
    }

    func getAgeSexAndBloodType() throws -> (age: Int, biologicalSex: HKBiologicalSex, bloodType: HKBloodType) {
            
        do {
            let birthdayComponents =  try healthKitStore.dateOfBirthComponents()
            let biologicalSex =       try healthKitStore.biologicalSex()
            let bloodType =           try healthKitStore.bloodType()
            
            let unwrappedBiologicalSex = biologicalSex.biologicalSex
            let unwrappedBloodType = bloodType.bloodType
            
            let todayDateComponents = Date().getDateComponents([.year])
            if let year = todayDateComponents.year, let birthdayYear = birthdayComponents.year {
                let age = year - birthdayYear
                return (age, unwrappedBiologicalSex, unwrappedBloodType)
            }

            return (0, unwrappedBiologicalSex, unwrappedBloodType)
        }
    }
    
    func getMostRecentSample(for sampleType: HKSampleType,
                             completion: @escaping (HKQuantitySample?, Error?) -> Void) {
        
        let mostRecentPredicate = HKQuery.predicateForSamples(withStart: Date.distantPast,
                                                              end: Date(),
                                                              options: .strictEndDate)
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        let limit = 1
        let sampleQuery = HKSampleQuery(sampleType: sampleType, predicate: mostRecentPredicate, limit: limit, sortDescriptors: [sortDescriptor]) { (query, samples, error) in
            
            guard let samples = samples, let mostRecentSample = samples.first as? HKQuantitySample else {
                completion(nil, error)
                return
            }
            
            completion(mostRecentSample, nil)
        }
        
        healthKitStore.execute(sampleQuery)
    }

    func getStepCount(completion: @escaping (_ stepRetrieved: Double) -> Void) {
        let type = HKSampleType.quantityType(forIdentifier: .stepCount)
        
        let cal = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let newDate = cal.startOfDay(for: Date())
        
        let predicate = HKQuery.predicateForSamples(withStart: newDate, end: Date(), options: []) // Our search predicate which will fetch all steps taken today
        let interval: NSDateComponents = NSDateComponents()
        interval.day = 1
        
        let query = HKStatisticsCollectionQuery(quantityType: type!, quantitySamplePredicate: predicate, options: .cumulativeSum, anchorDate: newDate, intervalComponents:(interval as NSDateComponents) as DateComponents)
        
        query.initialResultsHandler = { query, results, error in
            
            if error != nil {
                
                print("Something went Wrong")
                return
            }

            if let myResults = results{
                myResults.enumerateStatistics(from: newDate, to: Date()) { statistics, stop in
                    
                    if let quantity = statistics.sumQuantity() {
                        
                        let steps = quantity.doubleValue(for: HKUnit.count())                        
                        completion(steps)
                    }
                }
            }
        }
        
        healthKitStore.execute(query)
    }
}
