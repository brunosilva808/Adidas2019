//
//  UserHealthProfile.swift
//  Adidas 2019
//
//  Created by Bruno on 27/11/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import HealthKit

struct UserHealthProfile {
    
    var age: Int?
    var biologicalSex: HKBiologicalSex?
    var bloodType: HKBloodType?
    var heightInMeters: Double?
    var weightInKilograms: Double?
    
    var ageAsString: String? {
        get {
            if let age = self.age {
                return "Age: \(age)"
            } else {
                return "Age: -"
            }
        }
    }
    
    var biologicalSexAsString: String? {
        get {
            if let biologicalSex = self.biologicalSex {
                return "Sex: " + biologicalSex.stringRepresentation
            } else {
                return "Sex: -"
            }
        }
    }
    
    var bloodTypeAsString: String? {
        get {
            if let bloodType = self.bloodType {
                return "Blood type: " + bloodType.stringRepresentation
            } else {
                return "Blood type: -"
            }
        }
    }
    
    var bodyMassIndex: Double? {
        
        guard let weightInKilograms = weightInKilograms,
            let heightInMeters = heightInMeters,
            heightInMeters > 0 else {
                return nil
        }
        
        return (weightInKilograms/(heightInMeters*heightInMeters))
    }

}
