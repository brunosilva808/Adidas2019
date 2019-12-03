//
//  Date+Math.swift
//  Adidas 2019
//
//  Created by Bruno on 03/12/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import Foundation

extension Date {
    
    func differenceIn(dateComponents: Set<Calendar.Component>, to date: Date) -> Int {
        let calendar = Calendar.current
        let date1 = calendar.startOfDay(for: self)
        let date2 = calendar.startOfDay(for: date)
        
        let components = calendar.dateComponents(dateComponents, from: date1, to: date2)
        if let days = components.day, days != 0 {
            return days
        } else {
            return 1
        }
    }
}
