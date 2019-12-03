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
        let sampleQuery = HKSampleQuery(sampleType: sampleType,
                                        predicate: mostRecentPredicate,
                                        limit: limit,
                                        sortDescriptors: [sortDescriptor]) { (query, samples, error) in
            
            guard let samples = samples, let mostRecentSample = samples.first as? HKQuantitySample else {
                completion(nil, error)
                return
            }
            
            completion(mostRecentSample, nil)
        }
        
        healthKitStore.execute(sampleQuery)
    }
    
    func getQuantityType(for healthSample: HealthIdentifiers, completion: @escaping (_ stepRetrieved: Double) -> Void) {
        guard   let type = HKSampleType.quantityType(forIdentifier: healthSample.identifier),
                let startDate = UserDefaults.Adidas.get(key: .date) else {
            return
        }

        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: [])
        let interval: NSDateComponents = NSDateComponents()
        interval.day = 1//startDate.differenceIn(dateComponents: [.day], to: Date())
        
        let query = HKStatisticsCollectionQuery(quantityType: type,
                                                quantitySamplePredicate: predicate,
                                                options: .cumulativeSum,
                                                anchorDate: startDate,
                                                intervalComponents:(interval as DateComponents))
        
        query.initialResultsHandler = { query, results, error in
            
            if error != nil {
                return
            }
            
            if let myResults = results{
                myResults.enumerateStatistics(from: startDate, to: Date()) { statistics, stop in
                    
                    if let quantity = statistics.sumQuantity() {
                        
                        let value = quantity.doubleValue(for: healthSample.units)
                        completion(value)
                    }
                }
            }
        }
        
        healthKitStore.execute(query)
    }
}
