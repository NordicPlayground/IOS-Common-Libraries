//
//  RecordOperator.swift
//  iOSCommonLibraries
//
//  Created by Dinesh Harjani on 19/6/25.
//  Copyright © 2025 Nordic Semiconductor. All rights reserved.
//

import Foundation

// MARK: RecordOperator

public enum RecordOperator: UInt8, Hashable, Equatable, CustomStringConvertible, CaseIterable {
    case null = 0
    case allRecords = 1
    case lessThanOrEqual = 2
    case greaterThanOrEqual = 3
    case withinRange = 4
    case firstRecord = 5
    case lastRecord = 6
    
    public var description: String {
        switch self {
        case .null:
            return "Null"
        case .allRecords:
            return "All Records"
        case .lessThanOrEqual:
            return "Less Than Or Equal To"
        case .greaterThanOrEqual:
            return "Greater Than Or Equal To"
        case .withinRange:
            return "Within Range of"
        case .firstRecord:
            return "First Record (i.e. Oldest Record)"
        case .lastRecord:
            return "Last Record (i.e. Most Recent Record)"
        }
    }
}
