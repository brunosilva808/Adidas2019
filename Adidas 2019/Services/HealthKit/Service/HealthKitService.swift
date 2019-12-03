//
//  HealthKitManager.swift
//  Adidas 2019
//
//  Created by Bruno on 27/11/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import HealthKit

fileprivate enum HealthkitSetupError: Error {
    case notAvailableOnDevice
    case dataTypeNotAvailable
}

final class HealthKithService {
    
    private let profileDataStore: ProfileDataStore!
    
    init(profileDataStore: ProfileDataStore) {
        self.profileDataStore = profileDataStore
    }
    
    func authorizeHealthKit(completion: @escaping (Bool, Error?) -> Void) {
        //1. Check to see if HealthKit Is Available on this device
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(false, HealthkitSetupError.notAvailableOnDevice)
            return
        }
        
        //2. Prepare the data types that will interact with HealthKit
        guard   let dateOfBirth = HKObjectType.characteristicType(forIdentifier: .dateOfBirth),
            let bloodType = HKObjectType.characteristicType(forIdentifier: .bloodType),
            let biologicalSex = HKObjectType.characteristicType(forIdentifier: .biologicalSex),
            let bodyMassIndex = HKObjectType.quantityType(forIdentifier: .bodyMassIndex),
            let height = HKObjectType.quantityType(forIdentifier: .height),
            let distanceWalkingRunning = HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning),
            let stepCount = HKObjectType.quantityType(forIdentifier: .stepCount),
            let bodyMass = HKObjectType.quantityType(forIdentifier: .bodyMass),
            let activeEnergy = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned) else {
                
                completion(false, HealthkitSetupError.dataTypeNotAvailable)
                return
        }
        
        //3. Prepare a list of types you want HealthKit to read and write
        let healthKitTypesToWrite: Set<HKSampleType> = [bodyMassIndex,
                                                        activeEnergy,
                                                        distanceWalkingRunning,
                                                        stepCount,
                                                        HKObjectType.workoutType()]
        
        let healthKitTypesToRead: Set<HKObjectType> = [dateOfBirth,
                                                       bloodType,
                                                       biologicalSex,
                                                       bodyMassIndex,
                                                       height,
                                                       bodyMass,
                                                       distanceWalkingRunning,
                                                       stepCount,
                                                       HKObjectType.workoutType()]
        
        //4. Request Authorization
        HKHealthStore().requestAuthorization(toShare: healthKitTypesToWrite,
                                             read: healthKitTypesToRead) { (success, error) in
                                                completion(success, error)
        }
    }
    
    func getUserHealthProfile(onComplete: (UserHealthProfile) -> Void) {
        
        var userHealthProfile: UserHealthProfile = UserHealthProfile()
        
        do {
            let userAgeSexAndBloodType = try profileDataStore.getAgeSexAndBloodType()
            userHealthProfile.age = userAgeSexAndBloodType.age
            userHealthProfile.biologicalSex = userAgeSexAndBloodType.biologicalSex
            userHealthProfile.bloodType = userAgeSexAndBloodType.bloodType
        } catch {}
        
        onComplete(userHealthProfile)
    }
    
    func getMostRecentSampleForHeight(onComplete: @escaping (Double?) -> Void) {
        
        guard let heightSampleType = HKSampleType.quantityType(forIdentifier: .height) else {
            return
        }
        
        profileDataStore.getMostRecentSample(for: heightSampleType) { (sample, error) in
            let heightInMeters = sample?.quantity.doubleValue(for: HKUnit.meter())
            onComplete(heightInMeters)
        }
    }
    
    func getMostRecentSampleForWeight(onComplete: @escaping (Double?) -> Void) {

        guard let weightSampleType = HKSampleType.quantityType(forIdentifier: .bodyMass) else {
            return
        }
        
        profileDataStore.getMostRecentSample(for: weightSampleType) { (sample, error) in
            
            guard let sample = sample else {
                return
            }
            
            let weightInKilograms = sample.quantity.doubleValue(for: HKUnit.gramUnit(with: .kilo))
            onComplete(weightInKilograms)
        }
    }
    
    func getMostRecentSampleDistanceWalkingRunning(onComplete: @escaping (Double?) -> Void) {
        
        guard let distanceSampleType = HKSampleType.quantityType(forIdentifier: .distanceWalkingRunning) else {
            return
        }
        
        profileDataStore.getMostRecentSample(for: distanceSampleType) { (sample, error) in
            let walkingMeters = sample?.quantity.doubleValue(for: HKUnit.meter())
            onComplete(walkingMeters)
        }
    }

    func getStepCount(onComplete: @escaping (Double?) -> Void) {
        
        profileDataStore.getQuantityType(identifier: .stepCount, units: HKUnit.count()) { (distance) in
            onComplete(distance)
        }
    }
    
    func getDistanceWalkingRunning(onComplete: @escaping (Double?) -> Void) {
        
        profileDataStore.getQuantityType(identifier: .distanceWalkingRunning, units: HKUnit.meter()) { (distance) in
            onComplete(distance)
        }
    }

}
