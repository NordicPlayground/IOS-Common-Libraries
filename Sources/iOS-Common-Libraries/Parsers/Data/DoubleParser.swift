//
//  DoubleParser.swift
//  iOSCommonLibraries
//
//  Created by Sylwester Zieliński on 22/10/2025.
//

import Foundation

extension Double: DataParser {
    public static func size() -> Int {
        Float.size()
    }
    
    public static func parse(data: Data, offset: Int) throws -> Double {
        Double(try Float.parse(data: data, offset: offset))
    }
}
