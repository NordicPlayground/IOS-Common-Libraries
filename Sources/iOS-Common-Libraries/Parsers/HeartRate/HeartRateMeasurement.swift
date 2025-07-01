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
    
    public init(_ data: Data) {
        guard data.count >= Self.MinSize else {
            self.heartRateValue = 0
            self.sensorContact = .notSupported
            self.energyExpended = nil
            self.intervals = nil
            return
        }
        
        var offset = 0
        let flags = data.littleEndianBytes(atOffset: offset, as: UInt8.self)
        offset += MemoryLayout<UInt8>.size
        
        let is16BitValue = flags & 1 > 0
        sensorContact = SensorContact.fromFlags(flags)
        let isEnergyExpendedIncluded = flags & 8 > 0
        let rrIntervalStatus = flags & 16 > 0
        
        if is16BitValue, offset + MemoryLayout<UInt16>.size <= data.count {
            heartRateValue = data.littleEndianBytes(atOffset: offset, as: UInt16.self)
            offset += MemoryLayout<UInt16>.size
        } else {
            heartRateValue = data.littleEndianBytes(atOffset: offset, as: UInt8.self)
            offset += MemoryLayout<UInt8>.size
        }
        
        if isEnergyExpendedIncluded, offset + MemoryLayout<UInt16>.size < data.count {
            energyExpended = data.littleEndianBytes(atOffset: offset, as: UInt16.self)
            offset += MemoryLayout<UInt16>.size
        } else {
            energyExpended = nil
        }
        
        if rrIntervalStatus {
            var intervals = [TimeInterval]()
            while offset + MemoryLayout<UInt16>.size < data.count {
                let units = data.littleEndianBytes(atOffset: offset, as: UInt16.self)
                intervals.append(TimeInterval(units) * 1000.0 / 1024.0)
                offset += MemoryLayout<UInt16>.size
            }
            self.intervals = intervals
        } else {
            intervals = nil
        }
    }
}
