//
//  ViewController.swift
//  Adidas 2019
//
//  Created by Bruno on 26/11/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    weak var coordinator: ApplicationCoordinator?
    private var service: Service!
    private var healthKitService: HealthKithService!
    private var items: [ItemElement] = []
    private var buttonHealthKit: UIButton!
    private var headerTable: UserTableHeader!
    private var userHealthProfile: UserHealthProfile!

    init(service: Service, healthKitManager: HealthKithService) {
        super.init(nibName: nil, bundle: nil)
        
        self.service = service
        self.healthKitService = healthKitManager
    }
    
    deinit {
        service = nil
        healthKitService = nil
        headerTable = nil
        coordinator = nil
        userHealthProfile = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupButton()
        getGoalsFromService()
    }
    

    @objc func authorizeHealthKit() {
        
        healthKitService.authorizeHealthKit { [weak self] (authorized, error) in

            DispatchQueue.main.async {
                self?.buttonHealthKit.isHidden = true
            }
            
            guard authorized else {
                let message = "Error Health Kit authorization"
                
                if let error = error {
                    print("\(message). Reason: \(error.localizedDescription)")
                } else {
                    print(message)
                }
                
                return
            }
            
            print("HealthKit Successfully Authorized.")
            self?.getUserHealthProfile()
        }
    }

    fileprivate func setupTableView() {
        tableView.separatorStyle = .none
        tableView.register(GoalTableCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.registerHeaderFooter(UserTableHeader.self)
        headerTable = UserTableHeader(reuseIdentifier: "Header")
    }
    
    fileprivate func setupButton() {
        buttonHealthKit = UIButton(type: .roundedRect)
        buttonHealthKit.setTitle("Authorize health kit", for: .normal)
        buttonHealthKit.addTarget(self, action: #selector(authorizeHealthKit), for: .touchUpInside)
        buttonHealthKit.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(buttonHealthKit)
        NSLayoutConstraint.activate([
            buttonHealthKit.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            buttonHealthKit.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)])
    }
    
    fileprivate func getUserHealthProfile() {
        
        healthKitService.getUserHealthProfile(onComplete: { [weak self] (userHealthProfile) in
            DispatchQueue.main.async {
                self?.userHealthProfile = userHealthProfile
                self?.headerTable.model = userHealthProfile
                self?.tableView.reloadData()
            }
        })
        
        healthKitService.getMostRecentSampleForHeight() { [weak self] (height) in
            self?.userHealthProfile.heightInMeters = height
        }
        
        healthKitService.getMostRecentSampleForWeight { [weak self] (weight) in
            self?.userHealthProfile.weightInKilograms = weight
        }
        
    }
    
    fileprivate func getGoalsFromService() {
        
        service.getGoals { [weak self] (response) in
            DispatchQueue.main.async {
                self?.items = response
            }
        }
    }
    
}

extension ViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.reusableCell(for: indexPath, with: items[indexPath.row]) as GoalTableCell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.pushGoalViewController(goal: items[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerTable
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
    
}

