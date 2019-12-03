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

final class HealthKithService: HealthKitProtocol {
    private var profileDataStore: ProfileDataStore
    
    init(profileDataStore: ProfileDataStore) {
        self.profileDataStore = profileDataStore
    }
    
    func authorizeHealthKit(completion: @escaping (Bool, Error?) -> Void) {

        guard HKHealthStore.isHealthDataAvailable() else {
            completion(false, HealthkitSetupError.notAvailableOnDevice)
            return
        }
        
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
        
        HKHealthStore().requestAuthorization(toShare: healthKitTypesToWrite,
                                             read: healthKitTypesToRead) { (success, error) in
                                                completion(success, error)
        }
    }
    
}

extension HealthKithService {

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
    
    func getMostRecentSample(for healthSample: HealthIdentifiers, onComplete: @escaping (Double?) -> Void) {

        guard let weightSampleType = HKSampleType.quantityType(forIdentifier: healthSample.identifier) else {
            return
        }
        
        profileDataStore.getMostRecentSample(for: weightSampleType) { (sample, error) in
            
            guard let sample = sample else {
                return
            }
            
            let sampleQuantity = sample.quantity.doubleValue(for: healthSample.units)
            onComplete(sampleQuantity)
        }
    }
    
    func getSample(for healthSample: HealthIdentifiers, onComplete: @escaping (Double?) -> Void) {
        
        profileDataStore.getQuantityType(for: healthSample) { (distance) in
            onComplete(distance)
        }
    }

}
