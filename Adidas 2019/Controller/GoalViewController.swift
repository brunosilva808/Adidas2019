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
    private var cellButton: ButtonTableCell!
    private var cellTime: TimeTableCell!

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
     
//        tableView = UITableView(frame: view.frame, style: .grouped)
        setupCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadWorkout()
    }
    
    fileprivate func setupCells() {
        cellGoal = GoalTableCell(frame: .zero)
        cellGoal.model = goal
        
        cellTime = TimeTableCell(workoutSession: workoutSession)
        
        cellButton = ButtonTableCell(frame: .zero)
        cellButton.onButtonTouch = { [weak self] in
            switch self?.workoutSession.state {
            case .notStarted?, .finished?:
                self?.workoutSession.start()
                self?.cellTime.startTimer()
            case .active?:
                self?.workoutSession.end()
                self?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self?.doneButtonPressed))
            default:
                break
            }
            
            self?.cellTime.updateLabels()
        }
        
        cells.append(TableSectionData(rows: [cellGoal, cellTime, cellButton]))
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
        if let workoutComplete = workoutSession.completeWorkout {
            workoutDataStore.save(workout: workoutComplete) { [weak self] (response, error) in
                DispatchQueue.main.async {
                    if response {
                        self?.dismissAndClearSession()
                    } else {
                        self?.showErrorAlert()
                    }
                }
            }
        }
    }
    
    fileprivate func dismissAndClearSession() {
        workoutSession.clear()
        navigationController?.popViewController(animated: true)
    }
    
    fileprivate func showErrorAlert() {
        let alert: UIAlertController = UIAlertController(title: "", message: "Error saving", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    fileprivate func loadWorkout() {
        workoutDataStore.load() { [weak self] (workouts, error) in
            
            DispatchQueue.main.async {
                guard let workouts = workouts else {
                    return
                }

                self?.loadWorkoutCells(with: workouts)
                
                self?.healthKitService.getMostRecentSampleDistanceWalkingRunning(onComplete: { (distance) in
                    print(distance)
                })
                
                if let workout = workouts.first {
                    self?.healthKitService.getStepCount(workout: workout)
                    self?.healthKitService.getStepsCount()
                }
            }
        }
    }
    
    fileprivate func loadWorkoutCells(with workouts: [HKWorkout]) {
        print(workouts)
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
