//
//  BaseCell.swift
//  Rich People
//
//  Created by Bruno on 11/10/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import UIKit

class BaseCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUIComponents()
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUIComponents() {}
    func setupViews() {}
}
