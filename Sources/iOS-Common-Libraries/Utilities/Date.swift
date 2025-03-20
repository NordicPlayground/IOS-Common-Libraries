//
//  Date.swift
//  iOS-Common-Libraries
//
//  Created by Dinesh Harjani on 9/8/22.
//

import Foundation

// MARK: - Date Extension

public extension Date {
    
    // MARK: Constants
    
    static let DataSize = MemoryLayout<UInt16>.size + 5 * MemoryLayout<UInt8>.size
    
    // MARK: init
    
    init?(_ data: Data) {
        guard data.count >= Self.DataSize else { return nil }
        
        var offset = 0
        let year = data.littleEndianBytes(atOffset: offset, as: UInt16.self)
        offset += MemoryLayout<UInt16>.size
        let month = data.littleEndianBytes(atOffset: offset, as: UInt8.self)
        offset += MemoryLayout<UInt8>.size
        let day = data.littleEndianBytes(atOffset: offset, as: UInt8.self)
        offset += MemoryLayout<UInt8>.size
        let hours = data.littleEndianBytes(atOffset: offset, as: UInt8.self)
        offset += MemoryLayout<UInt8>.size
        let minutes = data.littleEndianBytes(atOffset: offset, as: UInt8.self)
        offset += MemoryLayout<UInt8>.size
        let seconds = data.littleEndianBytes(atOffset: offset, as: UInt8.self)

        let calendar = Calendar.current
        let dateComponents = DateComponents(calendar: calendar, year: year, month: month, day: day, hour: hours, minute: minutes, second: seconds)
        guard let date = calendar.date(from: dateComponents) else { return nil }
        self = date
    }
    
    // MARK: currentYear()
    
    static func currentYear() -> Int {
        guard let calendar = NSCalendar(calendarIdentifier: .gregorian) else {
            fatalError("Failed call to NSCalendar with Gregorian Calendar.")
        }
        return calendar.component(.year, from: Date())
    }
}
