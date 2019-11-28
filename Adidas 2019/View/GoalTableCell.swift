//
//  GoalTableCell.swift
//  Adidas 2019
//
//  Created by Bruno on 26/11/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import UIKit

class GoalTableCell: UITableViewCell, ModelPresenterCell {
    
    private var stackView: UIStackView!
    private var labelTitle: UILabel!
    private var labelDescription: UILabel!
    private var labelGoal: UILabel!
    private var labelThrophy: UILabel!
    private var labelPoints: UILabel!
    var model: ItemElement? {
        didSet {
            guard let model = model else {
                return
            }
            
            labelTitle.text = model.title
            labelDescription.text = model.itemDescription
            labelGoal.text = model.goalAsString
            labelPoints.text = model.reward.pointsAsString
            labelThrophy.text = model.reward.trophy
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUIComponents()
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension GoalTableCell {
    
    func setupUIComponents() {
        selectionStyle = .none

        labelTitle = UILabel(frame: .zero)
        labelTitle.font = UIFont.boldSystemFont(ofSize: 21)
//        labelTitle.backgroundColor = .red
        
        labelDescription = UILabel(frame: .zero)
        labelDescription.numberOfLines = 0
        
        labelGoal = UILabel(frame: .zero)
        labelPoints = UILabel(frame: .zero)
        labelThrophy = UILabel(frame: .zero)
        
        stackView = UIStackView(arrangedSubviews: [labelTitle, labelDescription, labelGoal, labelPoints, labelThrophy])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
    }

    func setupView() {
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)])
    }
    
}
