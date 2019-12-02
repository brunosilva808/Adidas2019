//
//  EntryViewController.swift
//  Adidas 2019
//
//  Created by Bruno on 02/12/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import UIKit

class EntryViewController: StaticTableController {

    var healthKitService: HealthKithService!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    init(healthKitService: HealthKithService) {
        super.init(nibName: nil, bundle: nil)
        
        self.healthKitService = healthKitService
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension EntryViewController {
    
    func authorizeHealthKit() {
        
        healthKitService.authorizeHealthKit { (authorized, error) in
            guard authorized else {
                return
            }
        }
    }
}

extension EntryViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        authorizeHealthKit()
    }
}
