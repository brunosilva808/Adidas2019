//
//  DetailTableCell.swift
//  Adidas 2019
//
//  Created by Bruno on 02/12/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import UIKit
import HealthKit

class DetailsTableCell: UITableViewCell {
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .medium
        return formatter
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(workout: HKWorkout) {
        textLabel?.text = dateFormatter.string(from: workout.startDate)
        if let caloriesBurned =
            workout.totalEnergyBurned?.doubleValue(for: .kilocalorie()) {
            let formattedCalories = String(format: "CaloriesBurned: %.2f",
                                           caloriesBurned)
            
            detailTextLabel?.text = formattedCalories
        } else {
            detailTextLabel?.text = nil
        }
    }
    
}
