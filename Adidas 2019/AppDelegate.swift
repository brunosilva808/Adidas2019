//
//  AppDelegate.swift
//  Adidas 2019
//
//  Created by Bruno on 26/11/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import UIKit
import HealthKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var applicationCoordinator: ApplicationCoordinator?
    var healthKitService: HealthKithService!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        InitializerManager().initialize(components: [.healthKitService])
        initRootViewController()
        
        return true
    }
    
    fileprivate func initRootViewController() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        self.applicationCoordinator = ApplicationCoordinator(window: window)
        
        applicationCoordinator?.start()
    }
    
}
