//
//  ParsingError.swift
//  iOSCommonLibraries
//
//  Created by Sylwester Zieliński on 17/10/2025.
//

import Foundation

public enum ParsingError: LocalizedError, CustomStringConvertible, Equatable {
    case invalidSize(actualSize: Int, expectedSize: Int)
    
    public var description: String {
        switch self {
        case .invalidSize(let actualSize, let expectedSize):
            return "Data Size of \(actualSize) bytes does not match minimum requirement of \(expectedSize) bytes."
        }
    }
    
    public var errorDescription: String? {
        description
    }
}
