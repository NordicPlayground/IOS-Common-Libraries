//
//  SensorType.swift
//  iOSCommonLibraries
//
//  Created by Dinesh Harjani on 19/6/25.
//  Copyright © 2025 Nordic Semiconductor. All rights reserved.
//

import Foundation

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
