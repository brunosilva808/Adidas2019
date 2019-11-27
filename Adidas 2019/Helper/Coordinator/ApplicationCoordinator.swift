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
        
        let urlSessionProvider = URLSessionProvider()
        let service = Service(sessionProvider: urlSessionProvider)
        let viewController = ViewController(service: service)
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
