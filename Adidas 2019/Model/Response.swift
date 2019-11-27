//
//  Response.swift
//  Adidas 2019
//
//  Created by Bruno on 26/11/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import Foundation

// MARK: - Item
struct Response: Codable {
    let items: [ItemElement]
    let nextPageToken: String
}

// MARK: - ItemElement
struct ItemElement: Codable {
    let id, title, itemDescription, type: String
    let goal: Int
    let reward: Reward
    
    var goalAsString: String {
        get {
            return "\(self.goal)"
        }
    }
    enum CodingKeys: String, CodingKey {
        case id, title
        case itemDescription = "description"
        case type, goal, reward
    }
}

// MARK: - Reward
struct Reward: Codable {
    let trophy: String
    let points: Int
    
    var pointsAsString: String {
        get {
            return "\(self.points) points"
        }
    }
}

