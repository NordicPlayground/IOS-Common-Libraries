//
//  CommonDataParser.swift
//  iOSCommonLibraries
//
//  Created by Dinesh Harjani on 27/5/25.
//  Copyright © 2025 Nordic Semiconductor. All rights reserved.
//

import Foundation

// MARK: - CommonDataParser

public struct CommonDataParser: NordicDataParser {
    
    // MARK: Properties
    
    public let name: String
    public let description: String
    
    private let meetsMinSize: ((Int) -> Bool)?
    private let parse: (Data) -> String?

    // MARK: init
         
    public init(name: String, description: String, meetsMinSize: ((Int) -> Bool)? = nil,
                parse: @escaping (Data) -> String?) {
        self.name = name
        self.description = description
        self.meetsMinSize = meetsMinSize
        self.parse = parse
    }
    
    // MARK: callAsFunction
    
    public func callAsFunction(_ item: Data) -> String? {
        guard meetsMinSize?(item.count) ?? true else { return nil }
        return parse(item)
    }
    
    // MARK: isValidDataLength
    
    public func isValidDataLength(_ data: Data) -> Bool {
        return meetsMinSize?(data.count) ?? true
    }
}

// MARK: Hashable, Equatable

extension CommonDataParser: Hashable, Equatable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
