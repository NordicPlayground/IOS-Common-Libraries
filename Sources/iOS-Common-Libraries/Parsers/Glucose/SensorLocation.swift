//
//  SensorLocation.swift
//  iOSCommonLibraries
//
//  Created by Dinesh Harjani on 19/6/25.
//  Copyright © 2025 Nordic Semiconductor. All rights reserved.
//

import Foundation

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
