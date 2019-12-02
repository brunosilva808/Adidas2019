//
//  GoalViewController.swift
//  Adidas 2019
//
//  Created by Bruno on 26/11/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import UIKit

class GoalViewController: StaticTableController {

    weak var coordinator: ApplicationCoordinator?
    private var workoutDataStore: WorkoutDataStore!
    private var workout: WorkoutInterval?
    private var goal: ItemElement!
    private var cellGoal: GoalTableCell!
    private var cellButton: ButtonTableCell!
    private var cellTime: TimeTableCell!
    private var workoutSession: WorkoutSession!
    private var barButton: UIBarButtonItem!
    private lazy var startTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    init(workoutDataStore: WorkoutDataStore, goal: ItemElement, workoutSession: WorkoutSession) {
        super.init(nibName: nil, bundle: nil)
        
        self.workoutDataStore = workoutDataStore
        self.goal = goal
        self.workoutSession = workoutSession
    }
    
    deinit {
        self.workoutSession = nil
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
    
    @objc func doneButtonPressed() {
        if let workoutComplete = workoutSession.completeWorkout {
            workoutDataStore.save(workout: workoutComplete) { [weak self] (response, error) in

                if response {
                    
                } else {
                    
                }
                
//                var alert: UIAlertController!
//                if response {
//                    alert = UIAlertController(title: "", message: "Saved with success", preferredStyle: .alert)
//                } else {
//                    alert = UIAlertController(title: "", message: "Error saving", preferredStyle: .alert)
//                }
//
//                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//                self?.present(alert, animated: true, completion: {
//                    self?.navigationItem.rightBarButtonItem = nil
//                })

            }
        }
    }
    
    fileprivate func dismissAndClearSession() {
        workoutSession.clear()
        self.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func setupCells() {
        cellGoal = GoalTableCell(frame: .zero)
        cellGoal.model = goal
        cells.append(cellGoal)
        
        cellTime = TimeTableCell(workoutSession: workoutSession)
        cells.append(cellTime)
        
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
        cells.append(cellButton)
    }
    
    fileprivate func setupTableView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            tableView.heightAnchor.constraint(equalToConstant: 200)])
    }
    
    fileprivate func loadWorkout() {
//        workoutDataStore.load(workout: workout) { (workouts, error) in
//            print(workouts)
//        }
    }

}
