//
//  UserTableHeader.swift
//  Adidas 2019
//
//  Created by Bruno on 28/11/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import UIKit

class StepsTableHeader: UITableViewHeaderFooterView, ModelPresenterCell {

    private var labelSteps: UILabel!
    private var labelSubTitle: UILabel!
    private var labelMedals: UILabel!
    private var labelMedalsTitle: UILabel!
    private var labelPoints: UILabel!
    private var labelPointsTitle: UILabel!
    private var stackViewHorizontal: UIStackView!
    private var stackViewVertical: UIStackView!
    private var stackViewMedals: UIStackView!
    private var stackViewPoints: UIStackView!
    var goalsManager: GoalsManager! {
        didSet {
            self.labelMedals.text = "\(goalsManager.getMedals().count)"
            self.labelPoints.text = "\(goalsManager.getPoints())"
        }
    }
    
    var model: Double? {
        didSet{
            guard let model = model else {
                return
            }
            
            labelSteps.text = String(format: " %.0f", model)
        }
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupUIComponents()
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension StepsTableHeader {
    
    func setupUIComponents() {
        let textDefault = "0"
        backgroundView = UIView(frame: self.bounds)
        backgroundView?.backgroundColor = .white

        labelSteps = UILabel(frame: .zero)
        labelSteps.text = textDefault
        labelSteps.textAlignment = .center
        labelSteps.font = UIFont.boldSystemFont(ofSize: 106)
        
        labelSubTitle = UILabel(frame: .zero)
        labelSubTitle.font = UIFont.systemFont(ofSize: 16)
        labelSubTitle.textColor = .gray
        labelSubTitle.textAlignment = .center
        labelSubTitle.text = "Total Steps"
        
        stackViewVertical = UIStackView(arrangedSubviews: [labelSteps, labelSubTitle])
        stackViewVertical.axis = .vertical
        stackViewVertical.translatesAutoresizingMaskIntoConstraints = false
        
        labelMedals = UILabel(frame: .zero)
        labelMedals.text = textDefault
        
        labelMedalsTitle = UILabel(frame: .zero)
        labelMedalsTitle.textColor = .gray
        labelMedalsTitle.text = "Medals"
        
        stackViewMedals = UIStackView(arrangedSubviews: [labelMedals, labelMedalsTitle])
        stackViewMedals.axis = .vertical

        labelPoints = UILabel(frame: .zero)
        labelPoints.text = textDefault
        
        labelPointsTitle = UILabel(frame: .zero)
        labelPointsTitle.textColor = .gray
        labelPointsTitle.text = "Points"
        
        stackViewPoints = UIStackView(arrangedSubviews: [labelPoints, labelPointsTitle])
        stackViewPoints.axis = .vertical
        
        stackViewHorizontal = UIStackView(arrangedSubviews: [stackViewMedals, stackViewPoints])
        
        stackViewVertical.addArrangedSubview(stackViewHorizontal)
    }
    
    func setupView() {
        addSubview(stackViewVertical)
        
        NSLayoutConstraint.activate([
            stackViewVertical.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            stackViewVertical.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            stackViewVertical.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            stackViewVertical.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)])
    }

}
