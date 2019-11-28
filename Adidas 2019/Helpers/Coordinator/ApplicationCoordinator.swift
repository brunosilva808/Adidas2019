//
//  MainCoordinator.swift
//  Rich People
//
//  Created by Bruno on 21/11/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import UIKit

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
        let profileDataStore = ProfileDataStore()
        let healthKitManager = HealthKithService(profileDataStore: profileDataStore)
        let dispatchGroup = DispatchGroup()
        let viewController = ViewController(service: service, healthKitManager: healthKitManager)
        viewController.coordinator = self

        rootViewController.pushViewController(viewController, animated: false)
    }
    
    func start() {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
    
    func pushGoalViewController() {
        let goalViewController = GoalViewController()
        goalViewController.coordinator = self
        rootViewController.pushViewController(goalViewController, animated: true)
    }
    
    func popViewController() {
        rootViewController.popViewController(animated: true)
    }
    
}
