//
//  AuthorizeTableCell.swift
//  Adidas 2019
//
//  Created by Bruno on 02/12/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import UIKit

class AuthorizeTableCell: UITableViewCell {

    private var button: UIButton!
    var onButtonTouch: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none

        setupUIComponents()
        setupView()
    }
    
    fileprivate func setupUIComponents() {
        button = UIButton(type: .roundedRect)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
    }
    
    fileprivate func setupView() {
        addSubview(button)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            button.heightAnchor.constraint(equalToConstant: 50)])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension AuthorizeTableCell {
    
    func setTitle(title: String) {
        button.setTitle(title, for: .normal)
    }
    
    @objc func buttonPressed() {
        onButtonTouch?()
    }

}
