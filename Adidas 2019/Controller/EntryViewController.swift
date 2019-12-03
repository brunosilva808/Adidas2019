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
    private var workoutTableCell: UITableViewCell!
    private var goalsTableCell: UITableViewCell!
    private var profileTableCell: UITableViewCell!
    
    override init(style: UITableView.Style) {
        super.init(style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableViewAndCells()
    }
    
    fileprivate func setupTableViewAndCells() {
        
        workoutTableCell = UITableViewCell()
        workoutTableCell.textLabel?.text = "Workout"
        workoutTableCell.textLabel?.textAlignment = .center
        
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

        let tableSectionData0 = TableSectionData(rows: [workoutTableCell])
        cells.append(tableSectionData0)
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
            coordinator?.pushWorkoutViewController()
            break
        case 1:
            coordinator?.pushHomeViewController()
            break
        case 2:
            coordinator?.pushStepsViewController()
        default:
            break
        }
    }
}
