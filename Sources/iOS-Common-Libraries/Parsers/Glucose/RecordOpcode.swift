//
//  RecordOpcode.swift
//  iOSCommonLibraries
//
//  Created by Dinesh Harjani on 19/6/25.
//  Copyright © 2025 Nordic Semiconductor. All rights reserved.
//

import Foundation

// MARK: RecordOpcode

public enum RecordOpcode: UInt8, Hashable, Equatable, CustomStringConvertible, CaseIterable {
    case reportStoredRecords = 1
    case deleteStoredRecords = 2
    case abortOperation = 3
    case reportNumberOfRecords = 4
    case numberOfStoredRecordsResponse = 5
    case responseCode = 6
    
    public var description: String {
        switch self {
        case .reportStoredRecords:
            return "Report Stored Records"
        case .deleteStoredRecords:
            return "Delete Stored Records"
        case .abortOperation:
            return "Abort Operation"
        case .reportNumberOfRecords:
            return "Report Number of Records"
        case .numberOfStoredRecordsResponse:
            return "Number of Stored Records Response"
        case .responseCode:
            return "Response Code"
        }
    }
}
