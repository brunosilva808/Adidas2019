//
//  Farfetch_2019Tests.swift
//  Farfetch 2019Tests
//
//  Created by Bruno on 28/10/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import XCTest
@testable import Adidas_2019

class MockUserDefaults : UserDefaults {
    
    convenience init() {
        self.init(suiteName: "Mock User Defaults")!
    }
    
    override init?(suiteName suitename: String?) {
        UserDefaults().removePersistentDomain(forName: suitename!)
        super.init(suiteName: suitename)
    }
    
}

class UserDefaultsTests: XCTestCase {

    var goals: [Goal]!
    
    override func setUp() {
        super.setUp()
        
        let reward = Reward(trophy: "trophy", points: 5)
        goals = [Goal(id: "1", title: "title",
                      itemDescription: "itemDescription",
                      type: Type.step,
                      goal: 100,
                      reward: reward),
                 Goal(id: "2", title: "title",
                      itemDescription: "itemDescription",
                      type: Type.step,
                      goal: 100,
                      reward: reward),
                 Goal(id: "3", title: "title",
                      itemDescription: "itemDescription",
                      type: Type.step,
                      goal: 100,
                      reward: reward)]
    }

    override func tearDown() {
        goals = nil
        super.tearDown()
    }
    
    func testSave_Goals_ShouldSuccessfullySave() {
        // Arrange
        let key = MockUserDefaults.Adidas.AnyDefaultKey.goals
        
        // Act
        MockUserDefaults.Adidas.set(array: goals, key: key)
        let value = MockUserDefaults.Adidas.getArray(objectType: Goal.self, key: key)
        
        // Assert
        XCTAssertEqual(goals.first?.id, value.first?.id, "Goals were not saved in UserDefaults")
    }
    
}
