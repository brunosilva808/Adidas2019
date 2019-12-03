//
//  Task.swift
//  NetworkLayer
//
//  Created by Bruno Silva on 16/11/2018.
//

typealias Parameters = [String: Any]

enum Task {
    case requestPlain
    case requestParameters(Parameters)
}
