//
//  GoalViewController.swift
//  Adidas 2019
//
//  Created by Bruno on 26/11/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import UIKit
import HealthKit

class WorkoutViewController: StaticTableController {

    weak var coordinator: ApplicationCoordinator?
    private var workoutService: WorkoutService!
    
    private var cellButton: ButtonTableCell!
    private var cellTime: TimeTableCell!

    private var barButton: UIBarButtonItem!
    
    init(workoutService: WorkoutService) {
        super.init(nibName: nil, bundle: nil)
        
        self.workoutService = workoutService
    }
    
    deinit {
        self.workoutService = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        setupCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadWorkout()
    }
    
    fileprivate func setupCells() {
        
        cellTime = TimeTableCell(workoutService: workoutService)
        
        cellButton = ButtonTableCell(frame: .zero)
        cellButton.onButtonTouch = { [weak self] in
            switch self?.workoutService.workoutState() {
            case .notStarted?, .finished?:
                self?.workoutService.startWorkout()
                self?.cellTime.startTimer()
            case .active?:
                self?.workoutService.endWorkout()
                self?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self?.doneButtonPressed))
            default:
                break
            }
            
            self?.cellTime.updateLabels()
        }
        
        cells.append(TableSectionData(rows: [cellTime, cellButton]))
    }
    
    fileprivate func setupTableView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            tableView.heightAnchor.constraint(equalToConstant: 200)])
    }
    
    @objc func doneButtonPressed() {
        workoutService.saveWorkout(onSuccess: { [weak self] in
            self?.dismissAndClearSession()
        }) { [weak self] in
            self?.showErrorAlert()
        }
    }
    
    fileprivate func dismissAndClearSession() {
        workoutService.clearSession()
        navigationController?.popViewController(animated: true)
    }
    
    fileprivate func showErrorAlert() {
        let alert: UIAlertController = UIAlertController(title: "",
                                                         message: "Could not save the workout",
                                                         preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    fileprivate func loadWorkout() {
        workoutService.loadWorkout(onSuccess: { [weak self] (workouts) in
            DispatchQueue.main.async {
                self?.loadWorkoutCells(with: workouts ?? [])
            }
        }) { (_) in }
    }
    
    fileprivate func loadWorkoutCells(with workouts: [HKWorkout]) {
        var cellsWorkout: [UITableViewCell] = []
        
        workouts.forEach {
            let cell = DetailsTableCell(style: .subtitle, reuseIdentifier: "detailCell")
            cell.setupCell(workout: $0)
            cellsWorkout.append(cell)
        }
        
        let tableSectionData = TableSectionData(sectionTitle: "Workouts", rows: cellsWorkout)
        cells.insert(tableSectionData, at: 1)
        
        tableView.reloadData()
    }

}
