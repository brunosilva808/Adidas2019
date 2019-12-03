//
//  HealthKitServiceTests.swift
//  Adidas 2019Tests
//
//  Created by Bruno on 03/12/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import XCTest
import HealthKit
@testable import Adidas_2019

class HealthKitServiceTests: XCTestCase {

    var healthKitService: HealthKithService!
    
    override func setUp() {
        super.setUp()
        
        let healthStore = HKHealthStore()
        var responseError: Error?
        var responseSuccess: Bool?
        let profileDataStore = ProfileDataStore(healthKitStore: healthStore)
        healthKitService = HealthKithService(profileDataStore: profileDataStore)

        let promise = expectation(description: "Wait for the authorization. Might be manual the first time")
        healthKitService.authorizeHealthKit { (response, error) in
            if response {
                responseSuccess = response
            } else {
                responseError = error
            }
            
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 10)
        XCTAssertNotNil(responseSuccess, "Received nil response while expecting a successful data")
        XCTAssertNil(responseError, "Received error while expecting successful response")
    }
    
    override func tearDown() {
        healthKitService = nil
        super.tearDown()
    }
    
    func testHeigthSample_Success() {
        // Arrange
        let sample = HealthSample.height
        var heightSample: Double?
        let promise = expectation(description: "Query for the height was executed")

        // Act
        healthKitService.getMostRecentSample(for: sample) { (height) in
            heightSample = height
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
        
        // Assert
        XCTAssertNotNil(heightSample, "Height sample is nil")
    }
    
    func testWeightSample_Success() {
        // Arrange
        let sample = HealthSample.weight
        var weightSample: Double?
        let promise = expectation(description: "Query for the weight was executed")
        
        // Act
        healthKitService.getMostRecentSample(for: sample) { (weight) in
            weightSample = weight
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
        
        // Assert
        XCTAssertNotNil(weightSample, "Weight sample is nil")
    }
    
    func testStepsSample_Success() {
        // Arrange
        let sample = HealthSample.steps
        var stepsSample: Double?
        let promise = expectation(description: "Query for the steps was executed")
        
        // Act
        healthKitService.getSample(for: sample) { (steps) in
            stepsSample = steps
            promise.fulfill()
        }
        wait(for: [promise], timeout: 10)
        
        // Assert
        XCTAssertNotNil(stepsSample, "Steps sample is nil. Check Health app")
    }
    
    func testDistanceWalkingRunningSample_Success() {
        // Arrange
        let sample = HealthSample.walkingRunning
        var distanceSample: Double?
        let promise = expectation(description: "Query for the distance was executed")
        
        // Act
        healthKitService.getSample(for: sample) { (distance) in
            distanceSample = distance
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
        
        // Assert
        XCTAssertNotNil(distanceSample, "Weight sample is nil. Check Health app")
    }
}
