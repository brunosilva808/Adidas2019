//
//  HKBiologicalSex+StringRepresentation.swift
//  Adidas 2019
//
//  Created by Bruno on 28/11/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import HealthKit

extension HKBiologicalSex {

    var stringRepresentation: String {
        switch self {
        case .female: return "female"
        case .male: return "male"
        case .other: return "other"
        default: return "unknown"
        }
    }

}
