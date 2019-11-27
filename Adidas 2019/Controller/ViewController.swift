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
    private var activityIndicator: UIActivityIndicatorView!
    private var service: Service!
    private var healthKitManager: HealthKithService!
    private var items: [ItemElement] = []
    private var buttonHealthKit: UIButton!

    init(service: Service, healthKitManager: HealthKithService) {
        super.init(nibName: nil, bundle: nil)
        
        self.service = service
        self.healthKitManager = healthKitManager
    }
    
    deinit {
        service = nil
        healthKitManager = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        setupActivityIndicator()
        setupTableView()
        setupButton()
    }
    
    @objc func authorizeHealthKit() {
        healthKitManager.authorizeHealthKit { [weak self] (authorized, error) in
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
            DispatchQueue.main.async {
                self?.buttonHealthKit.isHidden = true
                self?.getGoalsFromService()
            }
        }
    }
    
    fileprivate func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)])
    }
    
    fileprivate func setupTableView() {
        tableView.separatorStyle = .none
        tableView.register(GoalTableCell.self)
        tableView.rowHeight = UITableView.automaticDimension
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
    
    fileprivate func getGoalsFromService() {
        
        activityIndicator.startAnimating()
        
        service.getGoals { [weak self] (response) in
            DispatchQueue.main.async {
                self?.items = response
                self?.tableView.reloadData()
                self?.activityIndicator.stopAnimating()
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
        coordinator?.pushGoalViewController()
    }
    
}

