//
//  RecordResponseStatus.swift
//  iOSCommonLibraries
//
//  Created by Dinesh Harjani on 19/6/25.
//  Copyright © 2025 Nordic Semiconductor. All rights reserved.
//

import Foundation

// MARK: RecordOpcode

public enum RecordResponseStatus: UInt8, Hashable, Equatable, CustomStringConvertible, CaseIterable {
    case success = 1
    case opcodeNotSupported = 2
    case invalidOperator = 3
    case operatorNotSupported = 4
    case invalidOperand = 5
    case noRecords = 6
    case abortUnsuccessful = 7
    case notCompleted = 8
    case notSupported = 9
    
    public var description: String {
        switch self {
        case .success:
            return "Success"
        case .opcodeNotSupported:
            return "Opcode not supported"
        case .invalidOperator:
            return "Invalid operator"
        case .operatorNotSupported:
            return "Operator not supported"
        case .invalidOperand:
            return "Invalid operand"
        case .noRecords:
            return "No records found"
        case .abortUnsuccessful:
            return "Abort unsuccessful"
        case .notCompleted:
            return "Procedure not completed"
        case .notSupported:
            return "Not supported"
        }
    }
}
