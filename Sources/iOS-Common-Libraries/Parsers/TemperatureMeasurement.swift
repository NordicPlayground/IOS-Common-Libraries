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
    
    public let temperature: Measurement<UnitTemperature>
    public let timestamp: Date?
    public let location: Location?
    
    // MARK: - Init
    
    public init(_ data: Data) {
        guard data.count >= Self.MinSize else {
            self.temperature = Measurement<UnitTemperature>(value: Double.nan, unit: .celsius)
            self.timestamp = nil
            self.location = nil
            return
        }
        
        var offset = 0
        let flags = data.littleEndianBytes(atOffset: offset, as: UInt8.self)
        offset += 1
        
        let temperatureData = data.subdata(in: offset..<offset + MemoryLayout<UInt32>.size)
        offset += temperatureData.count
        let temperatureValue = Double(temperatureData)
        let isTemperatureInFahrenheit = flags & 1 == 1
        self.temperature = Measurement<UnitTemperature>(
            value: Double(temperatureValue), unit: isTemperatureInFahrenheit ? .fahrenheit : .celsius)
        
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
}

// MARK: - Location

public extension TemperatureMeasurement {
    
    enum Location: Int, Codable, CustomStringConvertible {
        case armpit = 1
        case body, ear, finger, gastrointestinal, mouth, rectum, toe, tympanum
        
        public var description: String {
            switch self {
            case .armpit:
                return "Armpit"
            case .ear:
                return "Ear"
            case .finger:
                return "Finger"
            case .body:
                return "Body - General"
            case .gastrointestinal:
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
