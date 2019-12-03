//
//  Adidas_2019Tests.swift
//  Adidas 2019Tests
//
//  Created by Bruno on 26/11/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import XCTest
@testable import Adidas_2019

class APITests: XCTestCase {
    var sessionProvider: URLSessionProvider!

    override func setUp() {
        super.setUp()
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [NetworkingMock.self]
        let session = URLSession(configuration: config)
        
        sessionProvider = URLSessionProvider(session: session)
        NetworkingMock.registerURLProtocol()
    }

    override func tearDown() {
        sessionProvider = nil
        super.tearDown()
        
        NetworkingMock.unregisterURLProtocol()
    }

    func testGoals_APIRequest_Success() {
        // Arranje
        let promise = expectation(description: "Async request completed")
        let service = AdidasService.goals
        _ = service.headers
        let typeObject = Response.self
        var result: [Goal]?
        var responseError: NetworkError?
        let request = URLRequest(service: service)
        
        guard let url = request.url else {
            XCTFail("URL is nil")
            return
        }
        guard let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil) else {
            XCTFail("Error creating HTTPURLResponse")
            return
        }
        let bundle = Bundle(for: type(of: self))
        let jsonData = MockFile().getData(fileName: .goals, fileType: .json, bundle: bundle)
        
        NetworkingMock.stub(url: url,
                            data: jsonData,
                            response: response,
                            error: nil)
        
        // Act
        sessionProvider.request(type: typeObject, service: service, completion: { (response) in
            switch response {
            case let .success(response):
                result = response.items
            case let .failure(error):
                responseError = error
            }
            
            promise.fulfill()
        })
        wait(for: [promise], timeout: 5)
        
        // Assert
        XCTAssertNil(responseError, "Received error while expecting successful response")
        XCTAssertNotNil(result, "Received nil response while expecting a successful data")
    }
    
    func testCharacters_APIRequest_ErrorDataNil() {
        // Arranje
        let promise = expectation(description: "Async request completed")
        let service = AdidasService.goals
        _ = service.headers
        let typeObject = Response.self
        var result: [Goal]?
        var responseError: NetworkError?
        let request = URLRequest(service: service)

        guard let url = request.url else {
            XCTFail("URL is nil")
            return
        }
        guard let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil) else {
            XCTFail("Error creating HTTPURLResponse")
            return
        }

        NetworkingMock.stub(url: url,
                            data: nil,
                            response: response,
                            error: nil)

        // Act
        sessionProvider.request(type: typeObject, service: service, completion: { (response) in
            switch response {
            case let .success(response):
                result = response.items
            case let .failure(error):
                responseError = error
            }

            promise.fulfill()
        })
        wait(for: [promise], timeout: 5)

        // Assert
        XCTAssertEqual(responseError, NetworkError.noJSONData, "Received nil error while expecting a no JSONData error")
        XCTAssertNotNil(responseError, "Received nil error while expecting an error")
        XCTAssertNil(result, "Received results while expecting nil")
    }

}
