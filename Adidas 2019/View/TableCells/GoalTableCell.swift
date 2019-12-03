//
//  GoalTableCell.swift
//  Adidas 2019
//
//  Created by Bruno on 26/11/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import UIKit

class GoalTableCell: BaseCell, ModelPresenterCell {
    
    private var stackView: UIStackView!
    private var stackViewHorizontal: UIStackView!
    private var labelTitle: UILabel!
    private var labelDescription: UILabel!
    private var imageViewMedal: UIImageView!
    var goalsManager: GoalsManager? {
        didSet {
            guard let goalsManager = goalsManager,
                  let model = self.model else {
                return
            }

            if goalsManager.checkIfGoalWasMeet(goal: model) {
                imageViewMedal.isHidden = false
            } else {
                imageViewMedal.isHidden = true
            }
        }
    }
    var model: Goal? {
        didSet {
            guard let model = model else {
                return
            }
            
            labelTitle.text = model.title
            labelDescription.text = model.itemDescription
        }
    }
    
    override func setupUIComponents() {
        selectionStyle = .none
        
        imageViewMedal = UIImageView(frame: CGRect(x: 0, y: 0, width: 21, height: 21))
        imageViewMedal.image = UIImage(imageLiteralResourceName: "medal")
        imageViewMedal.isHidden = true

        labelTitle = UILabel(frame: .zero)
        labelTitle.font = UIFont.boldSystemFont(ofSize: 21)
        
        labelDescription = UILabel(frame: .zero)
        labelDescription.numberOfLines = 0
        
        stackViewHorizontal = UIStackView(arrangedSubviews: [labelTitle, imageViewMedal])
        
        stackView = UIStackView(arrangedSubviews: [stackViewHorizontal, labelDescription])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
    }

    override func setupViews() {
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)])
    }
    
}
