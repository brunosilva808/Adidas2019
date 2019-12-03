//
//  Adidas_2019UITests.swift
//  Adidas 2019UITests
//
//  Created by Bruno on 26/11/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import XCTest

class Adidas_2019UITests: XCTestCase {

    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        let app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()
        
        let device = XCUIDevice.shared
        if UIDevice.current.userInterfaceIdiom == .phone {
            device.orientation = .portrait
        }
    }

    override func tearDown() {
        super.tearDown()
    }

    func testAuthorizeHealthKit() {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Authorize HealthKit"]/*[[".cells.buttons[\"Authorize HealthKit\"]",".buttons[\"Authorize HealthKit\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Turn All Categories On"]/*[[".cells.staticTexts[\"Turn All Categories On\"]",".staticTexts[\"Turn All Categories On\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Health Access"].buttons["Allow"].tap()
    }
    
    func testPresentGoalsViewController() {
        let app = XCUIApplication()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Goals"]/*[[".cells.staticTexts[\"Goals\"]",".staticTexts[\"Goals\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Adidas_2019.StepsView"].buttons["Back"].tap()
    }
    
    func testPresentProfileViewController() {
        let app = XCUIApplication()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Profile"]/*[[".cells.staticTexts[\"Profile\"]",".staticTexts[\"Profile\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Adidas_2019.UserProfileView"].buttons["Back"].tap()
    }
    
    func testPresentWorkoutProfileViewController() {
        let app = XCUIApplication()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Workout"]/*[[".cells.staticTexts[\"Workout\"]",".staticTexts[\"Workout\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Adidas_2019.WorkoutView"].buttons["Back"].tap()
    }
    
}
