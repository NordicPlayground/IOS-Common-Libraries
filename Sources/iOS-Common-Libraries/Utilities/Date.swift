//
//  Date.swift
//  iOS-Common-Libraries
//
//  Created by Dinesh Harjani on 9/8/22.
//

import Foundation

public extension Date {
    
    static func currentYear() -> Int {
        guard let calendar = NSCalendar(calendarIdentifier: .gregorian) else {
            fatalError("Failed call to NSCalendar with Gregorian Calendar.")
        }
        return calendar.component(.year, from: Date())
    }
}
