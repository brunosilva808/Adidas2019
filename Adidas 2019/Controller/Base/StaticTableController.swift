//
//  StaticTableViewController.swift
//  Rich People
//
//  Created by Bruno on 09/10/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import UIKit

struct TableSectionData {
    var sectionTitle: String?
    var rows: [UITableViewCell]
    
    init(sectionTitle: String? = nil, rows: [UITableViewCell]) {
        self.sectionTitle = sectionTitle
        self.rows = rows
    }
}

class StaticTableController: UITableViewController {

    var cells: [TableSectionData] = []
    
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return cells.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells[section].rows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cells[indexPath.section].rows[indexPath.row]
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return cells[section].sectionTitle
    }
}
