//
//  WorkoutServiceProtocol.swift
//  Adidas 2019
//
//  Created by Bruno on 03/12/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import Foundation
import HealthKit

protocol WorkoutServiceProtocol {
    func saveWorkout(onSuccess: @escaping () -> Void, onFailure: @escaping () -> Void)
    func loadWorkout(onSuccess: @escaping ([HKWorkout]?) -> Void, onFailure: @escaping (Error?) -> Void)
}
