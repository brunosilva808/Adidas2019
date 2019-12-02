//
//  EntryViewController.swift
//  Adidas 2019
//
//  Created by Bruno on 02/12/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import UIKit

class EntryViewController: StaticTableController {
    
    weak var coordinator: ApplicationCoordinator?
    private var authorizeTableCell: AuthorizeTableCell!
    private var goalsTableCell: UITableViewCell!
    private var profileTableCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableViewAndCells()
    }
    
    fileprivate func setupTableViewAndCells() {
        tableView = UITableView(frame: .zero, style: .grouped)
        
        goalsTableCell = UITableViewCell()
        goalsTableCell.textLabel?.text = "Goals"
        goalsTableCell.textLabel?.textAlignment = .center
        
        authorizeTableCell = AuthorizeTableCell()
        authorizeTableCell.setTitle(title: "Authorize HealthKit")
        authorizeTableCell.onButtonTouch = { [weak self] in
            self?.authorizeHealthKit()
        }
        
        profileTableCell = UITableViewCell()
        profileTableCell.textLabel?.text = "Profile"
        profileTableCell.textLabel?.textAlignment = .center

        let tableSectionData1 = TableSectionData(rows: [profileTableCell])
        cells.append(tableSectionData1)
        let tableSectionData2 = TableSectionData(rows: [goalsTableCell])
        cells.append(tableSectionData2)
        let tableSectionData3 = TableSectionData(rows: [authorizeTableCell])
        cells.append(tableSectionData3)
    }
}

extension EntryViewController {
    
    func authorizeHealthKit() {
        appDelegate.healthKitService.authorizeHealthKit { (authorized, error) in
            guard authorized else {
                return
            }
        }
    }
}

extension EntryViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            coordinator?.pushHomeViewController()
            break
        case 1:
            coordinator?.pushStepsViewController()
        default:
            break
        }
    }
}
