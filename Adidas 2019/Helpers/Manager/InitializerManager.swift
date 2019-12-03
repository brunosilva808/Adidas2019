//
//  InitializerManager.swift
//  Rich People
//
//  Created by Bruno on 11/11/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import UIKit
import HealthKit

enum InitializationComponent {
    case healthKitService
}

struct InitializerManager {
    
    func initialize(components: [InitializationComponent]) {
        
        components.forEach {
            switch $0 {
            case .healthKitService:
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let healthStore = HKHealthStore()
                let profileDataStore = ProfileDataStore(healthKitStore: healthStore)
                appDelegate.healthKitService = HealthKithService(profileDataStore: profileDataStore)
            }
        }
    }

}
