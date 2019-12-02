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
    let items: [Goal]
    let nextPageToken: String
}

// MARK: - Goal
struct Goal: Codable {
    let id, title, itemDescription: String
    let type: Type
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

enum Type: String, Codable {
    case step = "step"
    case walkingDistance = "walking_distance"
    case runningDistance = "running_distance"
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

