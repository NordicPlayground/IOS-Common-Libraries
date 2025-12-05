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
    
    public init(_ data: Data) throws {
        let reader = DataReader(data: data)
        
        let featureFlags = UInt(try reader.read(UInt8.self))
        let flagsRegister = BitField<TemperatureFlag>(featureFlags)
        
        self.temperature = Measurement<UnitTemperature>(value: Double(try reader.subdata(MemoryLayout<UInt32>.size)), unit: flagsRegister.contains(.fahrenheit) ? .fahrenheit : .celsius)
        self.timestamp = flagsRegister.contains(.timestamp) ? try reader.read() : nil
        self.location = flagsRegister.contains(.location) ? Location(rawValue: try reader.read(UInt8.self)) : nil
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
