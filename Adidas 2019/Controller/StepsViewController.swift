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
    private lazy var goalsManager: GoalsManager = GoalsManager()
    private var goals: [Goal] = []
    private var buttonHealthKit: UIButton!
    private var tableHeaderSteps: StepsTableHeader!

    init(service: Service) {
        super.init(nibName: nil, bundle: nil)
        
        self.service = service
    }
    
    deinit {
        service = nil
        tableHeaderSteps = nil
        coordinator = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        getGoals()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getStepCount()
    }

    fileprivate func setupTableView() {
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(GoalTableCell.self)
        tableView.registerHeaderFooter(StepsTableHeader.self)
        
        tableHeaderSteps = StepsTableHeader(reuseIdentifier: "Header")
    }
    
    fileprivate func getStepCount() {
        appDelegate.healthKitService.getStepCount { [weak self] (distance) in
            DispatchQueue.main.async {
                self?.tableHeaderSteps.model = distance
                self?.goalsManager.setDistance(distance: distance ?? 0)
            }
        }
        
        appDelegate.healthKitService.getDistanceWalkingRunning { (distance) in
            print("Running")
        }
    }
    
    fileprivate func getGoals() {
        service.getGoals { [weak self] (goals) in
            DispatchQueue.main.async {
                self?.goals = goals
                self?.goalsManager.setGoals(goals: goals)
                self?.tableHeaderSteps.goalsManager = self?.goalsManager
                self?.tableView.reloadData()
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension StepsViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.reusableCell(for: indexPath, with: goals[indexPath.row]) as GoalTableCell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.pushGoalViewController(goal: goals[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableHeaderSteps
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
    
}

