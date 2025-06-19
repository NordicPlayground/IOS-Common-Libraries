//
//  GlucoseMeasurement.swift
//  iOSCommonLibraries
//
//  Created by Dinesh Harjani on 10/6/25.
//  Copyright © 2025 Nordic Semiconductor. All rights reserved.
//

import Foundation

// MARK: - GlucoseMeasurement

/**
 'GlucoseMeasurement' as returned / used by GLS, Glucose Level Service.
 Not to be confused with CGMS or Continuous Glucose Monitoring Service.
 */
public struct GlucoseMeasurement {
    
    // MARK: Properties
    
    public let sequenceNumber: Int
    public let timestamp: Date
    public let timeOffset: Measurement<UnitDuration>?
    public let measurement: Measurement<UnitConcentrationMass>
    
    private let sensorCode: RegisterValue
    private let locationCode: RegisterValue
    private let statusCode: RegisterValue?
    
    // MARK: init
    
    public init?(_ data: Data) {
        guard data.canRead(UInt8.self, atOffset: 0) else { return nil }
        let featureFlags = UInt(data.littleEndianBytes(atOffset: 0, as: UInt8.self))
        let flags = BitField<GlucoseMeasurement.Flags>(featureFlags)
        
        guard data.canRead(UInt16.self, atOffset: 1) else { return nil }
        self.sequenceNumber = data.littleEndianBytes(atOffset: 1, as: UInt16.self)
        var offset = MemoryLayout<UInt8>.size + MemoryLayout<UInt16>.size
        
        guard data.count >= offset + Date.DataSize else { return nil }
        let dateData = data.subdata(in: offset ..< offset + Date.DataSize)
        guard let date = Date(dateData) else { return nil }
        self.timestamp = date
        offset += Date.DataSize
        
        if flags.contains(.timeOffset) {
            let timeOffset = data.littleEndianBytes(atOffset: offset, as: Int16.self)
            offset += MemoryLayout<UInt16>.size
            self.timeOffset = Measurement<UnitDuration>(value: Double(timeOffset), unit: .minutes)
        } else {
            self.timeOffset = nil
        }
        
        guard flags.contains(.typeAndLocation) else { return nil }
        let value = Float(asSFloat: data.subdata(in: offset..<offset+SFloatReserved.byteSize))
        offset += SFloatReserved.byteSize
        if flags.contains(.concentrationUnit) {
            measurement = Measurement<UnitConcentrationMass>(value: Double(value * 1000), unit: .gramsPerLiter)
        } else {
            measurement = Measurement<UnitConcentrationMass>(value: Double(value), unit: .millimolesPerLiter(withGramsPerMole: .bloodGramsPerMole))
        }
        
        guard data.canRead(UInt8.self, atOffset: offset) else { return nil }
        let typeAndLocation = data.littleEndianBytes(atOffset: offset, as: UInt8.self)
        offset += MemoryLayout<UInt8>.size
        self.sensorCode = RegisterValue((typeAndLocation & 0xF0) >> 4)
        self.locationCode = RegisterValue(typeAndLocation & 0x0F)
        
        if flags.contains(.statusAnnunciationPresent) {
            guard data.canRead(UInt8.self, atOffset: offset) else { return nil }
            self.statusCode = RegisterValue(data.littleEndianBytes(atOffset: offset, as: UInt8.self))
            offset += MemoryLayout<UInt8>.size
        } else {
            self.statusCode = nil
        }
    }
}

// MARK: - API

public extension GlucoseMeasurement {
    
    var sensorType: GlucoseMeasurement.SensorType? {
        GlucoseMeasurement.SensorType(rawValue: sensorCode)
    }
    
    func sensorString() -> String {
        if let sensorType {
            return sensorType.description
        } else {
            return GlucoseMeasurement.SensorType.reservedDescription(Int(sensorCode))
        }
    }
    
    var sensorLocation: GlucoseMeasurement.SensorLocation? {
        GlucoseMeasurement.SensorLocation(rawValue: locationCode)
    }
    
    func locationString() -> String {
        if let sensorLocation {
            return sensorLocation.description
        } else {
            return GlucoseMeasurement.SensorType.reservedDescription(Int(locationCode))
        }
    }
    
    var status: GlucoseMeasurement.Status? {
        guard let statusCode else { return nil }
        return GlucoseMeasurement.Status(rawValue: statusCode)
    }
    
    func statusString() -> String {
        guard let status else {
            return "Unknown"
        }
        return status.description
    }
    
    func toStringDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.setLocalizedDateFormatFromTemplate("E d MMM yyyy HH:mm:ss")
        return dateFormatter.string(from: timestamp)
    }
}

// MARK: - bloodGramsPerMole

extension Double {
    
    static let bloodGramsPerMole = 64.458
}

// MARK: - Flags

public extension GlucoseMeasurement {
    
    enum Flags: RegisterValue, Option, CaseIterable {
        
        case timeOffset, typeAndLocation, concentrationUnit, statusAnnunciationPresent
        case contextInfoFollows
    }
}
