//
//  TemperatureMeasurement.swift
//  nRF-Connect
//  iOSCommonLibraries
//
//  Created by Dinesh Harjani on 23/09/2020.
//  Created by Dinesh Harjani on 19/3/25.
//  Copyright © 2020 Nordic Semiconductor. All rights reserved.
//

import Foundation

// MARK: - TemperatureMeasurement

public struct TemperatureMeasurement {
    
    // MARK: Constants
    
    public static let MinSize = MemoryLayout<UInt8>.size + MemoryLayout<UInt32>.size
    
    // MARK: - Properties
    
    public let temperature: Float
    public let isTemperatureInFahrenheit: Bool
    public let timestamp: Date?
    public let location: Location?
    
    // MARK: - Init
    
    public init(_ data: Data) {
        guard data.count >= Self.MinSize else {
            self.temperature = 0.0
            self.isTemperatureInFahrenheit = false
            self.timestamp = nil
            self.location = nil
            return
        }
        
        var offset = 0
        let flags = data.littleEndianBytes(atOffset: offset, as: UInt8.self)
        offset += 1
        
        let temperatureData = data.subdata(in: offset..<offset + MemoryLayout<UInt32>.size)
        offset += temperatureData.count
        self.temperature = Float(temperatureData)
        self.isTemperatureInFahrenheit = flags & 1 == 1
        
        let isTimestampPresent = flags & 2 == 2
        let timestampSize = 7
        if isTimestampPresent, data.count >= offset + timestampSize {
            let timestampData = data.subdata(in: offset..<offset+timestampSize)
            offset += timestampSize
            self.timestamp = Date(timestampData)
        } else {
            self.timestamp = nil
        }
        
        let isSensorLocationPresent = flags & 4 == 4
        if isSensorLocationPresent, data.count >= offset + MemoryLayout<UInt8>.size {
            let sensor = data.littleEndianBytes(atOffset: offset, as: UInt8.self)
            self.location = Location(rawValue: sensor)
        } else {
            self.location = nil
        }
    }
    
    // MARK: API
    
    public func temperatureFormattedString() -> String {
        let measurement = Measurement<UnitTemperature>(value: Double(temperature), unit: isTemperatureInFahrenheit ? .fahrenheit : .celsius)
        return String(format: "%.2f\(measurement.unit.symbol)", measurement.value)
    }
}

// MARK: - Location

public extension TemperatureMeasurement {
    
    enum Location: Int, Codable, CustomStringConvertible {
        case armpit = 1
        case leftEar, leftFinger, body, rightEar, rightFinger, tract, mouth, rectum, toe, tympanum
        
        public var description: String {
            switch self {
            case .armpit:
                return "Armpit"
            case .leftEar, .rightEar:
                return "Ear"
            case .leftFinger, .rightFinger:
                return "Finger"
            case .body:
                return "Body - General"
            case .tract:
                return "Gastro - Intestinal Tract"
            case .mouth:
                return "Mouth"
            case .rectum:
                return "Rectum"
            case .toe:
                return "Toe"
            case .tympanum:
                return "Tympanum - Ear Drum"
            }
        }
    }
}
