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
    private var goal: Goal!
    
    private var cellGoal: GoalTableCell!

    private var barButton: UIBarButtonItem!
    
    init(goal: Goal) {
        super.init(nibName: nil, bundle: nil)
        
        self.goal = goal
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        setupTableViewAndCells()
    }
    
    fileprivate func setupTableViewAndCells() {
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        
        cellGoal = GoalTableCell(frame: .zero)
        cellGoal.model = goal
        
        cells.append(TableSectionData(rows: [cellGoal]))
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
