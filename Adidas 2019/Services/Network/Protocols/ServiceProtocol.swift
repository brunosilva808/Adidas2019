//
//  ServiceProtocol.swift
//  NetworkLayer
//
//  Created by Bruno Silva on 16/11/2018.
//

import Foundation

typealias Headers = [String: String]

protocol ServiceProtocol {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: Task { get }
    var headers: Headers? { get }
    var parametersEncoding: ParametersEncoding { get }
}

extension ServiceProtocol {
    var baseURL: URL {
        return URL(string: "https://thebigachallenge.appspot.com/_ah/api/myApi/v1/")!
    }
}
