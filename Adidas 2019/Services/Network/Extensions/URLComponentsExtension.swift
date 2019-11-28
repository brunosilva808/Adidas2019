//
//  URLComponentsExtension.swift
//  NetworkLayer
//
//  Created by Bruno Silva on 16/11/2018.
//

import Foundation

extension URLComponents {

    init(service: ServiceProtocol) {
        let url = service.baseURL.appendingPathComponent(service.path)
        self.init(url: url, resolvingAgainstBaseURL: false)!

        guard case let .requestParameters(parameters) = service.task, service.parametersEncoding == .url else { return }

        queryItems = parameters.map { key, value in
            return URLQueryItem(name: key, value: String(describing: value))
        }

        let urlQueryItems = [URLQueryItem(name: "apiKey", value: "58145f63433647a4884438f7fec6e6f5")]
        queryItems?.append(contentsOf: urlQueryItems)
    }
}
