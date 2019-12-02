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
    private var stackView: UIStackView!
    var model: Double? {
        didSet{
            guard let model = model else {
                return
            }
            
            labelSteps.text = String(format: "Steps: %.0f", model)
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
        backgroundView = UIView(frame: self.bounds)
        backgroundView?.backgroundColor = .white

        labelSteps = UILabel(frame: .zero)
        labelSteps.text = "0"
        labelSteps.textAlignment = .center
        labelSteps.font = UIFont.boldSystemFont(ofSize: 126)
        labelSubTitle = UILabel(frame: .zero)
        labelSubTitle.font = UIFont.systemFont(ofSize: 16)
        labelSubTitle.textColor = .gray
        labelSubTitle.textAlignment = .center
        labelSubTitle.text = "Total Steps"
        
        stackView = UIStackView(arrangedSubviews: [labelSteps, labelSubTitle])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupView() {
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)])
    }

}
