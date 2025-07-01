//
//  HeartRateSensorLocation.swift
//  iOSCommonLibraries
//
//  Created by Dinesh Harjani on 1/7/25.
//

import Foundation

// MARK: - SensorContact

public extension HeartRateMeasurement {
    
    enum SensorLocation: RegisterValue, Codable, CustomStringConvertible {
        case other = 0
        case chest = 1
        case wrist = 2
        case finger = 3
        case hand = 4
        case earLobe = 5
        case foot = 6
        
        public var description: String {
            switch self {
            case .other:
                return "Other"
            case .chest:
                return "Chest"
            case .wrist:
                return "Wrist"
            case .finger:
                return "Finger"
            case .hand:
                return "Hand"
            case .earLobe:
                return "Ear Lobe"
            case .foot:
                return "Foot"
            }
        }
    }
}
