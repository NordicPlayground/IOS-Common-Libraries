//
//  NordicDataParser.swift
//  nRF-Connect
//  iOSCommonLibraries
//
//  Created by Dinesh Harjani on 28/01/2019.
//  Created by Dinesh Harjani on 27/5/25.
//  Copyright © 2025 Nordic Semiconductor. All rights reserved.
//

import Foundation

// MARK: - NordicDataParser

public protocol NordicDataParser: Hashable, Equatable, CustomStringConvertible {
    
    // MARK: Properties
    
    var dataSizeRequirement: NordicDataParserValidSize { get }
    
    var description: String { get }
    
    // MARK: API
    
    func callAsFunction(_ item: Data) -> String?
}

// MARK: isValid()

public extension NordicDataParser {
    
    func isValid(_ data: Data) -> Bool {
        switch dataSizeRequirement {
        case .anySize:
            return true
        case .anyOf(let acceptedByteSizes):
            return acceptedByteSizes.contains(data.count)
        case .exactly(let byteCount):
            return data.count == byteCount
        case .atLeast(let minimumByteCount):
            return data.count >= minimumByteCount
        case .greaterThan(let byteCount):
            return data.count > byteCount
        }
    }
}

// MARK: - AcceptedDataSize

public enum NordicDataParserValidSize {
    case anySize
    case anyOf(_ acceptedByteCounts: [Int])
    case exactly(_ bytes: Int)
    case atLeast(_ bytes: Int)
    case greaterThan(_ bytes: Int)
}
