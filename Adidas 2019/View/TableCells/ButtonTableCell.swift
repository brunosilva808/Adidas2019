//
//  ButtonTableCell.swift
//  Adidas 2019
//
//  Created by Bruno on 02/12/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import UIKit

class ButtonTableCell: BaseCell {
    
    private var button: UIButton!
    private var workouStarted: Bool = false
    var onButtonTouch: (() -> Void)?
    
    override func setupUIComponents() {
        button = UIButton(type: .roundedRect)
        button.setTitleColor(.green, for: .normal)
        button.setTitle("Start Workout", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(startWorkout), for: .touchUpInside)
    }
    
    @objc func startWorkout() {
        workouStarted = !workouStarted
        if workouStarted {
            button.setTitleColor(.red, for: .normal)
            button.setTitle("Stop Workout", for: .normal)
        } else {
            button.setTitle("Start Workout", for: .normal)
            button.setTitleColor(.green, for: .normal)
        }
        
        onButtonTouch?()
    }
    
    override func setupViews() {
        addSubview(button)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            button.heightAnchor.constraint(equalToConstant: 50)])
    }
}
