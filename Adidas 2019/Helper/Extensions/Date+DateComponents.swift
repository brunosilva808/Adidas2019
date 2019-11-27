//
//  Date+DateComponents.swift
//  Adidas 2019
//
//  Created by Bruno on 27/11/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import Foundation

extension Date {
    
    func getDateComponents(calendar: Calendar = Calendar.current,
                           _ dateComponents: Set<Calendar.Component>) -> DateComponents {
        
        let calendar = calendar
        return calendar.dateComponents(dateComponents,
                                       from: self)
    }
    
}
