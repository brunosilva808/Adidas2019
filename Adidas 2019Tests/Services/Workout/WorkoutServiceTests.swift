//
//  WorkoutServiceTest.swift
//  Adidas 2019Tests
//
//  Created by Bruno on 03/12/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import XCTest
import HealthKit
@testable import Adidas_2019

class WorkoutServiceTests: XCTestCase {

    var workoutService: WorkoutService!
    
    override func setUp() {
        super.setUp()
        
        let healthStore = HKHealthStore()
        let workoutDataStore = WorkoutDataStore(healthStore: healthStore)
        let workoutSession = WorkoutSession()
        
        workoutService = WorkoutService(workoutDataStore: workoutDataStore, workoutSession: workoutSession)
    }
    
    override func tearDown() {
        workoutService = nil
        super.tearDown()
    }
    
    func testWorkout_Start() {
        // Arrange
        let state = WorkoutSessionState.active
        
        // Act
        workoutService.startWorkout()
        
        // Assert
        XCTAssertEqual(workoutService.workoutState(), state, "Workout didn't started")
        XCTAssertNotNil(workoutService.workoutStartDate(), "Workout start date nil")
    }
    
    func testWorkout_End() {
        // Arrange
        let state = WorkoutSessionState.finished
        
        // Act
        workoutService.startWorkout()
        workoutService.endWorkout()
        
        // Assert
        XCTAssertEqual(workoutService.workoutState(), state, "Workout didn't end")
        XCTAssertNotNil(workoutService.workoutEndDate(), "Workout end date nil")
    }
    
    func testWorkout_Clear() {
        // Arrange
        let state = WorkoutSessionState.notStarted
        
        // Act
        workoutService.startWorkout()
        workoutService.endWorkout()
        workoutService.clearSession()
        
        // Assert
        XCTAssertEqual(workoutService.workoutState(), state, "Workout didn't clear")
    }
    
    func testSaveLoad_Workout() {
        // Arrange
        var workoutsSample: [HKWorkout]?
        let promisseSave = expectation(description: "Workout saved")
        let promisseLoad = expectation(description: "Workout loaded")
        let exp = expectation(description: "Test after 5 seconds")
        
        // Act
        workoutService.startWorkout()

        if XCTWaiter.wait(for: [exp], timeout: 1.0) == XCTWaiter.Result.timedOut {
            
            workoutService.endWorkout()
            
            workoutService.saveWorkout(onSuccess: {
                promisseSave.fulfill()
            }) {
                XCTFail("Workout wasn't saved")
            }
            wait(for: [promisseSave], timeout: 10)
            
            workoutService.loadWorkout(onSuccess: { (workouts) in
                workoutsSample = workouts ?? []
                promisseLoad.fulfill()
            }) { _ in
                XCTFail("Workout wasn't loaded")
            }
            wait(for: [promisseLoad], timeout: 10)
            
            // Assert
            XCTAssertNotNil(workoutsSample, "Workouts weren't loaded with success")
        
        } else {
            XCTFail("Delay interrupted")
        }
    }
}
