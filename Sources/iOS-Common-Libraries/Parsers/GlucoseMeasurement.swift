//
//  GlucoseMeasurement.swift
//  iOSCommonLibraries
//
//  Created by Dinesh Harjani on 10/6/25.
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

// MARK: - SensorType

public extension GlucoseMeasurement {
    
    enum SensorType: RegisterValue, Option, CustomStringConvertible {
        case reservedForFutureUse
        case capillaryBlood, capillaryPlasma
        case venousBlood, venousPlasma
        case arterialBlood, arterialPlasma
        case undeterminedBlood, undeterminedPlasma
        case interstitialFluid
        case controlSolution
        
        public var description: String {
            switch self {
            case .reservedForFutureUse:
                return SensorType.reservedDescription(Int(0))
            case .capillaryBlood:
                return "Capillary Whole Blood"
            case .capillaryPlasma:
                return "Capillary Plasma"
            case .venousBlood:
                return "Venous Whole Blood"
            case .venousPlasma:
                return "Venous Plasma"
            case .arterialBlood:
                return "Arterial Whole Blood"
            case .arterialPlasma:
                return "Arterial Plasma"
            case .undeterminedBlood:
                return "Undetermined Whole Blood"
            case .undeterminedPlasma:
                return "Undetermined Plasma"
            case .interstitialFluid:
                return "Interstitial Fluid (ISF)"
            case .controlSolution:
                return "Control Solution"
            }
        }
        
        public static func reservedDescription(_ code: Int) -> String {
            return "Reserved For Future Use (\(code))"
        }
    }
}

// MARK: - SensorLocation

public extension GlucoseMeasurement {
    
    enum SensorLocation: RegisterValue, Option, CustomStringConvertible {
        case reservedForFutureUse
        case finger
        case alternate
        case earlobe
        case controlSolution
        case notAvailable = 0xF
        
        public var description: String {
            switch self {
            case .reservedForFutureUse:
                return SensorLocation.reservedDescription(Int(rawValue))
            case .finger:
                return "Finger"
            case .alternate:
                return "Alternate Site Test (AST)"
            case .earlobe:
                return "Earlobe"
            case .controlSolution:
                return "Control Solution"
            case .notAvailable:
                return "Location Not Available"
            }
        }
        
        public static func reservedDescription(_ code: Int) -> String {
            return "Reserved For Future Use (\(code))"
        }
    }
}

// MARK: - Status

public extension GlucoseMeasurement {
    
    enum Status: RegisterValue, Option, CustomStringConvertible {
        case deviceBatteryLow, sensorMalfunction, sampleSizeInsufficient
        case stripInsertionError, stripTypeIncorrect, sensorResultTooHigh, sensorResultTooLow
        case sensorTemperatureTooHigh, sensorTemperatureTooLow
        case sensorReadInterrupted, seneralDeviceFault, timeFault
        
        public var description: String {
            switch self {
            case .deviceBatteryLow:
                return "Device Battery Low"
            case .sensorMalfunction:
                return "Sensor Malfunction"
            case .sampleSizeInsufficient:
                return "Sample Size For Blood Or Control Solution Insufficient"
            case .stripInsertionError:
                return "Strip Insertion Error"
            case .stripTypeIncorrect:
                return "Strip Type Incorrect For Device"
            case .sensorResultTooHigh:
                return "Sensor Result Too High"
            case .sensorResultTooLow:
                return "Sensor Result Too Low"
            case .sensorTemperatureTooHigh:
                return "Sensor Temperature Too High"
            case .sensorTemperatureTooLow:
                return "Sensor Temperature Too Low"
            case .sensorReadInterrupted:
                return "Sensor Read Interrupted"
            case .seneralDeviceFault:
                return "General Device Fault"
            case .timeFault:
                return "Time Fault"
            }
        }
    }
}
