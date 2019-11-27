//
//  ViewController.swift
//  Adidas 2019
//
//  Created by Bruno on 26/11/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    weak var coordinator: ApplicationCoordinator?
    private var activityIndicator: UIActivityIndicatorView!
    private var service: Service!
    private var items: [ItemElement] = []

    init(service: Service) {
        super.init(nibName: nil, bundle: nil)
        
        self.service = service
    }
    
    deinit {
        service = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupActivityIndicator()
        setupTableView()
        getGoalsFromService()
    }
    
    fileprivate func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)])
    }
    

    fileprivate func setupTableView() {
        
        tableView.register(GoalTableCell.self)
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    fileprivate func getGoalsFromService() {
        
        activityIndicator.startAnimating()
        
        service.getGoals { [weak self] (response) in
            DispatchQueue.main.async {
                self?.items = response
                self?.tableView.reloadData()
                self?.activityIndicator.stopAnimating()
            }
        }
    }
    
}

extension ViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.reusableCell(for: indexPath, with: items[indexPath.row]) as GoalTableCell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.pushGoalViewController()
    }
    
}

