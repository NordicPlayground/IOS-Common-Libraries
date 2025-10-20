//
//  HeartRateMeasurement.swift
//  nRF-Connect
//  iOSCommonLibraries
//
//  Created by Dinesh Harjani on 1/3/22.
//  Created by Dinesh Harjani on 20/3/25.
//  Copyright © 2025 Nordic Semiconductor. All rights reserved.
//

import Foundation

// MARK: - HeartRateMeasurement

public struct HeartRateMeasurement {
    
    // MARK: Constants
    
    public static let MinSize = MemoryLayout<UInt8>.size + MemoryLayout<UInt8>.size
    
    // MARK: - Properties
    
    public let heartRateValue: Int
    public let sensorContact: SensorContact
    public let energyExpended: Int?
    public let intervals: [TimeInterval]?
    
    // MARK: - Init
    
    public init(_ data: Data) throws {
        let reader = DataReader(data: data)
        let flags = Int(try reader.read(UInt8.self))
        
        let is16BitValue = flags & 1 > 0
        sensorContact = SensorContact.fromFlags(flags)
        let isEnergyExpendedIncluded = flags & 8 > 0
        let rrIntervalStatus = flags & 16 > 0
        
        if is16BitValue {
            heartRateValue = Int(try reader.read(UInt16.self))
        } else {
            heartRateValue = Int(try reader.read(UInt8.self))
        }
        
        energyExpended = isEnergyExpendedIncluded ? Int(try reader.read(UInt16.self)) : nil
        
        if rrIntervalStatus {
            var intervals = [TimeInterval]()
            while reader.hasData(MemoryLayout<UInt16>.size) {
                let units = Int(try reader.read(UInt16.self))
                intervals.append(TimeInterval(units) * 1000.0 / 1024.0)
            }
            self.intervals = intervals
        } else {
            intervals = nil
        }
    }
}
