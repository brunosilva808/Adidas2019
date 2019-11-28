//
//  Service.swift
//  Adidas 2019
//
//  Created by Bruno on 26/11/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import Foundation

final class Service {
    private var sessionProvider: URLSessionProvider!
    
    init(sessionProvider: URLSessionProvider) {
        self.sessionProvider = sessionProvider
    }
    
    func getGoals(completion: @escaping ([ItemElement]) -> Void ) {
        self.sessionProvider.request(type: Response.self, service: AdidasService.goals) { (response) in
            switch response {
            case let .success(items):
                UserDefaults.Adidas.set(array: items.items, key: .goals)
                completion(items.items)
            case .failure(_):
                let items: [ItemElement] = UserDefaults.Adidas.getArray(objectType: ItemElement.self, key: .goals)
                completion(items)
            }
        }
    }

}
