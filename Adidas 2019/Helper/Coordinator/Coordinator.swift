//
//  Coordinator.swift
//  Rich People
//
//  Created by Bruno on 21/11/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import UIKit

//https://www.hackingwithswift.com/articles/175/advanced-coordinator-pattern-tutorial-ios
//https://medium.com/@hooliooo/yet-another-post-explaining-what-coordinators-are-in-ios-559de8cd6550
protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    
    func start()
}
