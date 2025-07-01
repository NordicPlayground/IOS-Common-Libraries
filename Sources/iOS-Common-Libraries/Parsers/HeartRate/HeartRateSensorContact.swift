//
//  SensorContact.swift
//  iOSCommonLibraries
//
//  Created by Dinesh Harjani on 1/7/25.
//

import Foundation

// MARK: - SensorContact

public extension HeartRateMeasurement {
    
    enum SensorContact: Int, Codable, CustomStringConvertible {
        case notSupported, supportedButNotDetected, supportedAndDetected
        
        public var description: String {
            switch self {
            case .notSupported:
                return "Sensor contact not supported"
            case .supportedButNotDetected:
                return "Sensor contact not detected"
            case .supportedAndDetected:
                return "Sensor contact detected"
            }
        }
        
        static func fromFlags(_ flags: Int) -> SensorContact {
            let sensorContactStatus = (flags & 6) >> 1
            switch sensorContactStatus {
            case 3:
                return .supportedAndDetected
            case 2:
                return .supportedButNotDetected
            case 0, 1:
                return .notSupported
            default:
                return .notSupported
            }
        }
    }
}
