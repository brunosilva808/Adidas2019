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
        
        let viewController = EntryViewController()
        viewController.coordinator = self
        rootViewController.pushViewController(viewController, animated: false)
    }
    
    func getService() -> Service {
        let urlSessionProvider = URLSessionProvider()
        return Service(sessionProvider: urlSessionProvider)
    }
    
    func start() {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
    
    func pushStepsViewController() {
        let service = getService()
        let viewController = StepsViewController(service: service)
        viewController.coordinator = self
        
        rootViewController.pushViewController(viewController, animated: true)
    }
    
    func pushGoalViewController(goal: Goal) {
        let healthStore = HKHealthStore()
        let workoutDataStore = WorkoutDataStore(healthStore: healthStore)
        let workoutSession = WorkoutSession()
        let goalViewController = GoalViewController(workoutDataStore: workoutDataStore,
                                                    goal: goal,
                                                    workoutSession: workoutSession)
        goalViewController.coordinator = self
        rootViewController.pushViewController(goalViewController, animated: true)
    }
    
    func pushHomeViewController() {
        let viewController = UserProfileViewController()
        viewController.coordinator = self
        
        rootViewController.pushViewController(viewController, animated: true)
    }
    
    func popViewController() {
        rootViewController.popViewController(animated: true)
    }
    
}
