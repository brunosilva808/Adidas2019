//
//  HealthIdentifier.swift
//  Adidas 2019
//
//  Created by Bruno on 03/12/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import Foundation
import HealthKit

protocol HealthIdentifiers {
    var identifier: HKQuantityTypeIdentifier { get }
    var units: HKUnit { get }
}
