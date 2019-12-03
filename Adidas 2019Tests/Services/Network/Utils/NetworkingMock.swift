//
//  NetworkingMock.swift
//  Farfetch 2019Tests
//
//  Created by Bruno on 31.08.2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import Foundation

class NetworkingMock: URLProtocol {
    private static var stubs = [URL: Stub]()
    private struct Stub {
        let data: Data?
        let response: HTTPURLResponse
        let error: Error?
    }
    
    static func stub(url: URL, data: Data?, response: HTTPURLResponse, error: Error?) {
        stubs[url] = Stub(data: data, response: response, error: error)
    }
    
    override func startLoading() {
        guard let url = request.url, let stub = NetworkingMock.stubs[url] else { return }
        
        if let data = stub.data {
            client?.urlProtocol(self, didReceive: stub.response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
        } else if let error = stub.error {
            client?.urlProtocol(self, didFailWithError: error)
        }

        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {
        
    }
    
    override class func canInit(with request: URLRequest) -> Bool {
        guard let url = request.url else { return false }
        
        return stubs[url] != nil
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    static func registerURLProtocol() {
        URLProtocol.registerClass(NetworkingMock.self)
    }
    
    static func unregisterURLProtocol() {
        stubs = [URL: Stub]()
        URLProtocol.unregisterClass(NetworkingMock.self)
    }
}
