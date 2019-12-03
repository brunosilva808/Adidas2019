//
//  ViewController.swift
//  Adidas 2019
//
//  Created by Bruno on 26/11/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import UIKit

class UserProfileViewController: StaticTableController {

    weak var coordinator: ApplicationCoordinator?
    private var userHealthProfile: UserHealthProfile!
    private var cellBiologicalSex: UITableViewCell!
    private var cellHeight: UITableViewCell!
    private var cellWeigth: UITableViewCell!
    private var cellAge: UITableViewCell!
    private var cellBloodType: UITableViewCell!
    private var cellMassIndex: UITableViewCell!
    private lazy var dispatchGroup = DispatchGroup()
    
    init(style: UITableView.Style, userHealthProfile: UserHealthProfile) {
        super.init(style: style)
        
        self.userHealthProfile = userHealthProfile
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        coordinator = nil
        userHealthProfile = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableViewAndCells()
        populateCells()
        getUserHealthProfile()
    }

    fileprivate func setupTableViewAndCells() {        
        cellAge = UITableViewCell()
        cellHeight = UITableViewCell()
        cellBiologicalSex = UITableViewCell()
        cellWeigth = UITableViewCell()
        cellBloodType = UITableViewCell()
        cellMassIndex = UITableViewCell()
        
        let tableSectionData1 = TableSectionData(rows: [cellAge,
                                                        cellHeight,
                                                        cellWeigth,
                                                        cellBiologicalSex,
                                                        cellBloodType])
        cells.append(tableSectionData1)
        let tableSectionData2 = TableSectionData(rows: [cellMassIndex])
        cells.append(tableSectionData2)
    }
    
    fileprivate func populateCells() {
        cellAge.textLabel?.text = userHealthProfile.ageAsString
        cellBloodType.textLabel?.text = userHealthProfile.bloodTypeAsString
        cellWeigth.textLabel?.text = userHealthProfile.weightAsString
        cellHeight.textLabel?.text = userHealthProfile.heightAsString
        cellBiologicalSex.textLabel?.text = userHealthProfile.biologicalSexAsString
        cellMassIndex.textLabel?.text = userHealthProfile.bodyMassIndexAsString
    }
    
    fileprivate func getUserHealthProfile() {
        
        appDelegate.healthKitService.getUserHealthProfile(onComplete: { [weak self] (userHealthProfile) in
            self?.userHealthProfile = userHealthProfile
            
            self?.dispatchGroup.enter()
            self?.appDelegate.healthKitService.getMostRecentSampleForHeight() { [weak self] (height) in
                self?.userHealthProfile.heightInMeters = height
                self?.dispatchGroup.leave()
            }
            
            self?.dispatchGroup.enter()
            self?.appDelegate.healthKitService.getMostRecentSampleForWeight { [weak self] (weight) in
                self?.userHealthProfile.weightInKilograms = weight
                self?.dispatchGroup.leave()
            }
            
            dispatchGroup.notify(queue: .main) {
                self?.populateCells()
            }
        })
    }

}
