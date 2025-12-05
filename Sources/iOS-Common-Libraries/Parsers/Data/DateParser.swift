//
//  DateParser.swift
//  iOSCommonLibraries
//
//  Created by Sylwester Zieliński on 22/10/2025.
//

import Foundation

extension Date: DataParser {
    public static func size() -> Int {
        Date.DataSize
    }
    
    public static func parse(data: Data, offset: Int) throws -> Date {
        try data.readDate(from: offset)
    }
}
