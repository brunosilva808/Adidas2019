//
//  TimeTableCell.swift
//  Adidas 2019
//
//  Created by Bruno on 02/12/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import UIKit

class TimeTableCell: BaseCell {
    
    private var labelTime: UILabel!
    private var timer: Timer!
    private var workoutService: WorkoutService!
    private lazy var startTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    private lazy var durationFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = [.pad]
        return formatter
    }()
    
    init(workoutService: WorkoutService) {
        super.init(style: .default, reuseIdentifier: "timeTableCell")

        self.workoutService = workoutService
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupUIComponents() {
        selectionStyle = .none
        
        labelTime = UILabel(frame: .zero)
        labelTime.textAlignment = .center
        labelTime.text = "00:00"
        labelTime.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func setupViews() {
        addSubview(labelTime)
        
        NSLayoutConstraint.activate([
            labelTime.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            labelTime.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            labelTime.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            labelTime.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            labelTime.heightAnchor.constraint(equalToConstant: 50)])
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.updateLabels()
        }
    }
    
    func updateLabels() {
        switch workoutService.workoutState() {
        case .active:
            let duration = Date().timeIntervalSince(workoutService.workoutStartDate())
            labelTime.text = durationFormatter.string(from: duration)
        case .finished:
            let duration = workoutService.workoutEndDate().timeIntervalSince(workoutService.workoutStartDate())
            labelTime.text = durationFormatter.string(from: duration)
            timer = nil
        default:
            labelTime.text = "00:00"
        }
    }
}
