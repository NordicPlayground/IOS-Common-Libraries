//
//  DataParser.swift
//  iOSCommonLibraries
//
//  Created by Sylwester Zieliński on 22/10/2025.
//

import Foundation

public protocol DataParser {
    associatedtype Parsable = Self where Parsable == Self
    
    static func size() -> Int
    
    static func parse(data: Data, offset: Int) throws -> Parsable
}
