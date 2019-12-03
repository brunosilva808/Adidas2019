//
//  HealthSample.swift
//  Adidas 2019
//
//  Created by Bruno on 03/12/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import Foundation
import HealthKit

enum HealthSample: HealthIdentifiers {
    
    case steps
    case walkingRunning
    case weight
    case height
    
    var identifier: HKQuantityTypeIdentifier {
        switch self {
        case .steps:
            return .stepCount
        case .walkingRunning:
            return .distanceWalkingRunning
        case .weight:
            return .bodyMass
        case .height:
            return .height
        }
    }
    
    var units: HKUnit {
        switch self {
        case .steps:
            return HKUnit.count()
        case .walkingRunning:
            return HKUnit.meter()
        case .weight:
            return HKUnit.gramUnit(with: .kilo)
        case .height:
            return HKUnit.meter()
        }
    }
}
