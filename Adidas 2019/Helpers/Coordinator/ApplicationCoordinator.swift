//
//  MainCoordinator.swift
//  Rich People
//
//  Created by Bruno on 21/11/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import UIKit
import HealthKit

class ApplicationCoordinator: Coordinator {
    internal var childCoordinators: [Coordinator] = []
    private let window: UIWindow
    private let rootViewController: UINavigationController
    
    init(window: UIWindow) {
        self.window = window
        rootViewController = UINavigationController()
        rootViewController.view.backgroundColor = .white
        
        let urlSessionProvider = URLSessionProvider()
        let service = Service(sessionProvider: urlSessionProvider)
        let healthStore = HKHealthStore()
        let profileDataStore = ProfileDataStore(healthKitStore: healthStore)
        let healthKitManager = HealthKithService(profileDataStore: profileDataStore)
        let viewController = ViewController(service: service, healthKitManager: healthKitManager)
        viewController.coordinator = self

        rootViewController.pushViewController(viewController, animated: false)
    }
    
    func start() {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
    
    func pushGoalViewController(goal: ItemElement) {
        let healthStore = HKHealthStore()
        let workoutDataStore = WorkoutDataStore(healthStore: healthStore)
        let workoutSession = WorkoutSession()
        let profileDataStore = ProfileDataStore(healthKitStore: healthStore)
        let healthKitService = HealthKithService(profileDataStore: profileDataStore)
        let goalViewController = GoalViewController(workoutDataStore: workoutDataStore,
                                                    goal: goal,
                                                    workoutSession: workoutSession,
                                                    healthKitService: healthKitService)
        goalViewController.coordinator = self
        rootViewController.pushViewController(goalViewController, animated: true)
    }
    
    func popViewController() {
        rootViewController.popViewController(animated: true)
    }
    
}
