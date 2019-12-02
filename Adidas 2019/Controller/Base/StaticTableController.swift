//
//  StaticTableViewController.swift
//  Rich People
//
//  Created by Bruno on 09/10/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import UIKit

class StaticTableController: UITableViewController {

    var cells: [UITableViewCell] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
    }

    fileprivate func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
    }
}

extension StaticTableController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cells[indexPath.row]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
}
