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
    public let measurement: Measurement<UnitConcentrationMass>?
    public let status: BitField<GlucoseMeasurement.Status>?
    
    private let sensorCode: RegisterValue
    private let locationCode: RegisterValue
    
    // MARK: init
    
    public init(_ data: Data) throws {
        let reader = DataReader(data: data)

        let featureFlags = UInt(try reader.read() as UInt8)
        let flags = BitField<GlucoseMeasurement.Flags>(featureFlags)
        
        self.sequenceNumber = try reader.read(UInt16.self)
        self.timestamp = try reader.read()
        
        timeOffset = flags.contains(.timeOffset) ? Measurement<UnitDuration>(value: Double(try reader.read(UInt16.self)), unit: .minutes) : nil

        if flags.contains(.typeAndLocation) {
            if flags.contains(.concentrationUnit) {
                measurement = Measurement<UnitConcentrationMass>(value: try reader.read(), unit: .millimolesPerLiter(withGramsPerMole: .bloodGramsPerMole))
            } else {
                measurement = Measurement<UnitConcentrationMass>(value: try reader.read(), unit: .milligramsPerDeciliter)
            }
        } else {
            measurement = nil
        }
        
        if flags.contains(.typeAndLocation) {
            let typeAndLocation = try reader.read(UInt8.self)
            self.locationCode = RegisterValue((typeAndLocation & 0xF0) >> 4)
            self.sensorCode = RegisterValue(typeAndLocation & 0x0F)
        } else {
            self.locationCode = 0
            self.sensorCode = 0
        }
        
        status = flags.contains(.statusAnnunciationPresent) ? BitField<GlucoseMeasurement.Status>(RegisterValue(try reader.read(UInt16.self))) : nil
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
    
    func statusString() -> String {
        guard let status else {
            return "Unknown"
        }
        return ListFormatter().string(from: status.map(\.description)) ?? "Unknown"
    }
    
    func toStringDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.setLocalizedDateFormatFromTemplate("E d MMM yyyy HH:mm:ss")
        return dateFormatter.string(from: timestamp)
    }
}

// MARK: - bloodGramsPerMole

public extension Double {
    
    static let bloodGramsPerMole = 64.458
}

// MARK: - Flags

public extension GlucoseMeasurement {
    
    enum Flags: RegisterValue, Option, CaseIterable {
        
        case timeOffset, typeAndLocation, concentrationUnit, statusAnnunciationPresent
        case contextInfoFollows
    }
}
