//
//  ModelPresenterTests.swift
//  Farfetch 2019Tests
//
//  Created by Bruno on 02/11/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import XCTest
@testable import Adidas_2019

class ModelPresenterMock: ModelPresenterCell {
    var model: String?
    
    init(model: String) {
        self.model = model
    }
}

class ModelPresenterTests: XCTestCase {
    
    var model: ModelPresenterMock!
    var testString: String!
    
    override func setUp() {
        super.setUp()
        
        testString = "Test"
        model = ModelPresenterMock(model: testString)
    }
    
    override func tearDown() {
        model = nil
        testString = nil
        super.tearDown()
    }
    
    func testSave_WithCharacterId_ShouldSuccessfullySave() {
        // Assert
        XCTAssertEqual(testString, model.model, "Strings are not equal")
    }
    
}
