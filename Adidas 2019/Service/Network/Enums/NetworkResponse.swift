//
//  NetworkResponse.swift
//  NetworkLayer
//
//  Created by Bruno Silva on 16/11/2018.
//

enum NetworkResponse<T> {
    case success(T)
    case failure(NetworkError)
}
