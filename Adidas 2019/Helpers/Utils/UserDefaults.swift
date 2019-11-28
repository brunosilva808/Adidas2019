//
//  Constatns.swift
//  Adidas 2019
//
//  Created by Bruno on 30/10/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import Foundation

// MARK: - Key Namespaceable

protocol KeyNamespaceable { }

extension KeyNamespaceable {
    static func namespace<T>(_ key: T) -> String
        where T: RawRepresentable {
            return "\(Self.self).\(key.rawValue)"
    }
}

// MARK: - Any Defaults

protocol AnyUserDefaultable: KeyNamespaceable {
    associatedtype AnyDefaultKey : RawRepresentable
}

extension AnyUserDefaultable where AnyDefaultKey.RawValue == String {
    
    static func set<T: Codable>(array: [T], key: AnyDefaultKey) {
        if let encoded = try? JSONEncoder().encode(array) {
            let keyRaw = namespace(key)
            UserDefaults.standard.set(encoded, forKey: keyRaw)
        }
    }
    
    static func getArray<T: Decodable>(objectType: T.Type, key: AnyDefaultKey) -> [T] {
        let keyRaw = namespace(key)
        
        if let data = UserDefaults.standard.object(forKey: keyRaw) as? Data {
            if let objects = try? JSONDecoder().decode([T].self, from: data) {
                return objects
            }
        }

        return []
    }
    
}

// MARK: - Use: Items

extension UserDefaults {
    struct Adidas: AnyUserDefaultable {
        private init() { }
        
        enum AnyDefaultKey: String {
            case goals
        }
    }
}
