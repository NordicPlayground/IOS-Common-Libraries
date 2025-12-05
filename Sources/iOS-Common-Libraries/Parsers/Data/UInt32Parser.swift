//
//  UInt32Parser.swift
//  iOSCommonLibraries
//
//  Created by Sylwester Zieliński on 22/10/2025.
//

import Foundation

extension UInt32: DataParser {
    public static func size() -> Int {
        MemoryLayout<Self>.size
    }
    
    public static func parse(data: Data, offset: Int) throws -> UInt32 {
        try data.read(fromOffset: offset)
    }
}
