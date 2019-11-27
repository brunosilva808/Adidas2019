//
//  Spinner.swift
//  Farfetch 2019
//
//  Created by Bruno on 04/11/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import UIKit

enum ActivityIndicatorAnimation {
    case start
    case stop
}

class ActivityIndicatorManager: UIView {
    fileprivate weak var activityIndicator: UIActivityIndicatorView!
    fileprivate weak var tableView: UITableView!
    var isAnimating: Bool {
        get {
            if activityIndicator.isAnimating {
                return true
            } else {
                return false
            }
        }
    }

    init(activityIndicator: UIActivityIndicatorView, tableView: UITableView) {
        super.init(frame: activityIndicator.frame)
        
        self.activityIndicator = activityIndicator
        self.tableView = tableView
        self.tableView.tableFooterView = self.activityIndicator
        self.tableView.tableFooterView?.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAnimation(_ activity: ActivityIndicatorAnimation) {
        switch activity {
        case .start:
            activityIndicator.startAnimating()
            tableView.tableFooterView?.isHidden = false
        case .stop:
            activityIndicator.stopAnimating()
            tableView.tableFooterView?.isHidden = true
        }
    }
    
}
