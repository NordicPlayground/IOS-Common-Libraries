//
//  DataReader.swift
//  iOSCommonLibraries
//
//  Created by Sylwester Zieliński on 17/10/2025.
//

import Foundation

public class DataReader {
    public let data: Data
    private var offset: Int = 0
    
    public init(data: Data) {
        self.data = data
    }
    
    public func hasData(_ size: Int) -> Bool {
        return offset + size <= data.count
    }
    
    public func readSFloat() throws -> Float {
        guard hasData(SFloatReserved.byteSize) else {
            throw ParsingError.invalidSize(actualSize: data.count, expectedSize: offset + SFloatReserved.byteSize)
        }
        defer { offset += SFloatReserved.byteSize }
        return Float(asSFloat: data.subdata(in: offset..<offset + SFloatReserved.byteSize))
    }

    public func readDate() throws -> Date {
        guard hasData(Date.DataSize) else {
            throw ParsingError.invalidSize(actualSize: data.count, expectedSize: offset + Date.DataSize)
        }
        defer { offset += Date.DataSize }
        return Date(data.subdata(in: offset..<offset + Date.DataSize))!
    }
    
    public func read<T: FixedWidthInteger>(_ type: T.Type) throws -> T {
        defer { offset += MemoryLayout<T>.size }
        return try data.read(fromOffset: offset)
    }
}
