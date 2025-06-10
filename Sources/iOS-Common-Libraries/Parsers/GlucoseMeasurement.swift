//
//  GlucoseMeasurement.swift
//  iOSCommonLibraries
//
//  Created by Dinesh Harjani on 10/6/25.
//

import Foundation

// MARK: - GlucoseMeasurement

public struct GlucoseMeasurement {
    
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
        case capillaryBlood, capillaryPlasma
        case venousBlood, venousPlasma
        case arterialBlood, arterialPlasma
        case undeterminedBlood, undeterminedPlasma
        case interstitialFluid
        case controlSolution
        
        public var description: String {
            switch self {
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
        case finger
        case alternate
        case earlobe
        case controlSolution
        case notAvailable
        
        public var description: String {
            switch self {
            case .finger:
                return "Finger"
            case .alternate:
                return "Alternate Site Test (AST)"
            case .earlobe:
                return "Earlobe"
            case .controlSolution:
                return "Control Solution"
            case .notAvailable:
                return "Value Not Available"
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
        case deviceBatteryLow, sensorMalfunction, sampleSizeForBloodOrControlSolutionInsufficient
        case stripInsertionError, stripTypeIncorrectForDevice, sensorResultTooHigh, sensorResultTooLow
        case sensorTemperatureTooHigh, sensorTemperatureTooLow
        case sensorReadInterrupted, seneralDeviceFault, timeFault
        
        public var description: String {
            switch self {
            case .deviceBatteryLow:
                return "Device Battery Low"
            case .sensorMalfunction:
                return "Sensor Malfunction"
            case .sampleSizeForBloodOrControlSolutionInsufficient:
                return "Sample Size For Blood Or Control Solution Insufficient"
            case .stripInsertionError:
                return "Strip Insertion Error"
            case .stripTypeIncorrectForDevice:
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
