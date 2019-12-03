//
//  URLSessionProvider.swift
//  NetworkLayer
//
//  Created by Bruno Silva on 16/11/2018.
//

import Foundation

final class URLSessionProvider: ProviderProtocol {

    private var session: URLSessionProtocol

    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    func request<T>(type: T.Type,
                    service: ServiceProtocol,
                    completion: @escaping (NetworkResponse<T>) -> Void) where T: Decodable {
        let request = URLRequest(service: service)

        let task = session.dataTask(request: request, completionHandler: { [weak self] data, response, error in
            let httpResponse = response as? HTTPURLResponse
            self?.handleDataResponse(data: data, response: httpResponse, error: error, service: service, completion: completion)
        })
        task.resume()
    }

    private func handleDataResponse<T: Decodable>(data: Data?,
                                                  response: HTTPURLResponse?,
                                                  error: Error?,
                                                  service: ServiceProtocol,
                                                  completion: (NetworkResponse<T>) -> Void) {
        guard error == nil else { return completion(.failure(.unknown)) }
        guard let response = response else { return completion(.failure(.noJSONData)) }

        switch response.statusCode {
        case 200...299:
            guard let parsedData = data, let model = try? JSONDecoder().decode(T.self, from: parsedData) else {
//                if let text = String(bytes: data!, encoding: .utf8) {
//                    print()
//                }

                return completion(.failure(.unknown))
            }
            
            completion(.success(model))
        default:
            completion(.failure(.unknown))
        }
    }
}
