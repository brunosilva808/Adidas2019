//
//  HKBloodType+stringRepresentation.swift
//  Adidas 2019
//
//  Created by Bruno on 28/11/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import HealthKit

extension HKBloodType {
    
    var stringRepresentation: String {
        switch self {
        case .notSet: return "Unknown"
        case .aPositive: return "A+"
        case .aNegative: return "A-"
        case .bPositive: return "B+"
        case .bNegative: return "B-"
        case .abPositive: return "AB+"
        case .abNegative: return "AB-"
        case .oPositive: return "O+"
        case .oNegative: return "O-"
        }
    }

}
