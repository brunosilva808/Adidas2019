//
//  PostService.swift
//  NetworkLayer
//
//  Created by Bruno Silva on 16/11/2018.
//

import Foundation

enum AdidasService: ServiceProtocol {

    case goals

    var path: String {
        switch self {
        case .goals:
            return "goals"
        }
    }

    var method: HTTPMethod {
        return .get
    }

    var task: Task {
        switch self {
        case .goals:
            return .requestPlain
        }
    }

    var headers: Headers? {
        return nil
    }

    var parametersEncoding: ParametersEncoding {
        return .url
    }
}
