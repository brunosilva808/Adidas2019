//
//  GoalViewController.swift
//  Adidas 2019
//
//  Created by Bruno on 26/11/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import UIKit
import HealthKit

class GoalViewController: StaticTableController {

    weak var coordinator: ApplicationCoordinator?
    private var workoutDataStore: WorkoutDataStore!
    private var workoutSession: WorkoutSession!
    private var healthKitService: HealthKithService!
    private var goal: ItemElement!
    
    private var cellGoal: GoalTableCell!
    private var cellSteps: DetailsTableCell!

    private var barButton: UIBarButtonItem!
    
    init(workoutDataStore: WorkoutDataStore, goal: ItemElement, workoutSession: WorkoutSession, healthKitService: HealthKithService) {
        super.init(nibName: nil, bundle: nil)
        
        self.workoutDataStore = workoutDataStore
        self.goal = goal
        self.workoutSession = workoutSession
        self.healthKitService = healthKitService
    }
    
    deinit {
        self.workoutSession = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        setupTableViewAndCells()
        healthKitService.getStepCount { [weak self] (distance) in
            DispatchQueue.main.async {
                self?.cellSteps.setupCell(title: String(format: "Steps: %.0f", distance ?? 0))
            }
        }
    }
    
    fileprivate func setupTableViewAndCells() {
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        
        cellGoal = GoalTableCell(frame: .zero)
        cellGoal.model = goal
        
        cellSteps = DetailsTableCell(style: .subtitle, reuseIdentifier: "detailCell")
        
        cells.append(TableSectionData(rows: [cellGoal, cellSteps]))
    }
    
    fileprivate func setupTableView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            tableView.heightAnchor.constraint(equalToConstant: 200)])
    }

}
