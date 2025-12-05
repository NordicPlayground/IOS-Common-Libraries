//
//  SFloatParser.swift
//  iOSCommonLibraries
//
//  Created by Sylwester Zieliński on 22/10/2025.
//

import Foundation

extension Float: DataParser {
    public static func size() -> Int {
        SFloatReserved.byteSize
    }
    
    public static func parse(data: Data, offset: Int) throws -> Float {
        Float(asSFloat: data.subdata(in: offset..<offset + SFloatReserved.byteSize))
    }
}
