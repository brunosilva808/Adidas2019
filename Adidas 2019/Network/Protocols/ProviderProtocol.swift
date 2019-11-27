//
//  ProviderProtocol.swift
//  NetworkLayer
//
//  Created by Bruno Silva on 16/11/2018.
//

protocol ProviderProtocol {
    func request<T>(type: T.Type,
                    service: ServiceProtocol,
                    completion: @escaping (NetworkResponse<T>) -> Void) where T: Decodable
}
