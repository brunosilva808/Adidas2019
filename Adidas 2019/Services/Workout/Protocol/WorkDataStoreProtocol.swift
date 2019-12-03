//
//  WorkDataStoreProtocol.swift
//  Adidas 2019
//
//  Created by Bruno on 03/12/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import Foundation
import HealthKit

protocol WorkoutDataStoreProtocol {
    func save(workout: Workout, completion: @escaping ((Bool, Error?) -> Void))
    func load(completion: @escaping ([HKWorkout]?, Error?) -> Void)
}
