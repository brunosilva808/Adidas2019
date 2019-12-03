//
//  UserTableHeader.swift
//  Adidas 2019
//
//  Created by Bruno on 28/11/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import UIKit

class UserTableHeader: UITableViewHeaderFooterView, ModelPresenterCell {

    private var labelAge: UILabel!
    private var labelBiologicalSex: UILabel!
    private var labelBloodType: UILabel!
    private var stackView: UIStackView!
    var model: UserHealthProfile? {
        didSet{
            guard let model = model else {
                return
            }
            
            labelAge.text = model.ageAsString
            labelBiologicalSex.text = model.biologicalSex?.stringRepresentation
            labelBloodType.text = model.bloodType?.stringRepresentation
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

extension UserTableHeader {
    
    func setupUIComponents() {
        backgroundView = UIView(frame: self.bounds)
        backgroundView?.backgroundColor = .white

        labelAge = UILabel(frame: .zero)
        labelAge.font = UIFont.boldSystemFont(ofSize: 18)
        labelBiologicalSex = UILabel(frame: .zero)
        labelBiologicalSex.font = UIFont.boldSystemFont(ofSize: 18)
        labelBloodType = UILabel(frame: .zero)
        labelBloodType.font = UIFont.boldSystemFont(ofSize: 18)
        
        stackView = UIStackView(arrangedSubviews: [labelAge, labelBiologicalSex, labelBloodType])
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
