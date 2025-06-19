//
//  Status.swift
//  iOSCommonLibraries
//
//  Created by Dinesh Harjani on 19/6/25.
//  Copyright © 2025 Nordic Semiconductor. All rights reserved.
//

import Foundation

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
