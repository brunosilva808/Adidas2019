//
//  ViewController.swift
//  Adidas 2019
//
//  Created by Bruno on 26/11/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import UIKit

class StepsViewController: UITableViewController {

    weak var coordinator: ApplicationCoordinator?
    private var service: Service!
    private var healthKitService: HealthKithService!
    private var items: [ItemElement] = []
    private var buttonHealthKit: UIButton!
    private var tableHeaderSteps: StepsTableHeader!

    init(service: Service, healthKitManager: HealthKithService) {
        super.init(nibName: nil, bundle: nil)
        
        self.service = service
        self.healthKitService = healthKitManager
    }
    
    deinit {
        service = nil
        healthKitService = nil
        tableHeaderSteps = nil
        coordinator = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupButton()
        getGoalsFromService()
        
//        self.view.backgroundColor = .red
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
            self?.getStepCount()
        }
    }

    fileprivate func setupTableView() {
        tableView.separatorStyle = .none
        tableView.register(GoalTableCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.registerHeaderFooter(StepsTableHeader.self)
        tableHeaderSteps = StepsTableHeader(reuseIdentifier: "Header")
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
    
    fileprivate func getStepCount() {
        
        healthKitService.getStepCount { [weak self] (distance) in
            DispatchQueue.main.async {
                self?.tableHeaderSteps.model = distance
            }
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

extension StepsViewController {

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
        return tableHeaderSteps
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
    
}

