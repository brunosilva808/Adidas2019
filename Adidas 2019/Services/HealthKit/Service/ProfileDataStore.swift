//
//  ProfileDataStore.swift
//  Adidas 2019
//
//  Created by Bruno on 27/11/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import HealthKit

struct ProfileDataStore {

    func getAgeSexAndBloodType() throws -> (age: Int, biologicalSex: HKBiologicalSex, bloodType: HKBloodType) {
            
        let healthKitStore = HKHealthStore()
            
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

}
