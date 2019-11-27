//
//  URLRequestExtension.swift
//  NetworkLayer
//
//  Created by Bruno Silva on 16/11/2018.
//

import Foundation

extension URLRequest {

    init(service: ServiceProtocol) {
        let urlComponents = URLComponents(service: service)

        self.init(url: urlComponents.url!)

        httpMethod = service.method.rawValue
//        service.headers?.forEach { key, value in
//            addValue(value, forHTTPHeaderField: key)
//        }

//        guard case let .requestParameters(parameters) = service.task,
//        service.parametersEncoding == .json else { return }
//        httpBody = try? JSONSerialization.data(withJSONObject: parameters)
    }
}
