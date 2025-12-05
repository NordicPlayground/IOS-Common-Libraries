//
//  DataReader.swift
//  iOSCommonLibraries
//
//  Created by Sylwester Zieliński on 22/10/2025.
//

import Foundation

public class DataReader {
    public let data: Data
    private var offset: Int = 0
    
    public init(data: Data) {
        self.data = data
    }
    
    public func size() -> Int {
        return offset
    }
    
    public func hasData<T: FixedWidthInteger>(_ type: T.Type) -> Bool {
        return offset + MemoryLayout<T>.size <= data.count
    }
    
    public func hasData(_ size: Int) -> Bool {
        return offset + size <= data.count
    }
    
    public func subdata(_ size: Int) throws -> Data {
        guard hasData(size) else {
            throw ParsingError.invalidSize(actualSize: data.count, expectedSize: offset + size)
        }
        let value = data.subdata(in: offset..<offset + size)
        offset += size
        return value
    }
    
    public func read<T: DataParser>() throws -> T {
        guard hasData(T.size()) else {
            throw ParsingError.invalidSize(actualSize: data.count, expectedSize: offset + T.size())
        }
        let value = try T.parse(data: data, offset: offset)
        offset += T.size()
        return value
    }
    
    public func read<T: FixedWidthInteger>(_ type: T.Type) throws -> Int {
        guard hasData(T.self) else {
            throw ParsingError.invalidSize(actualSize: data.count, expectedSize: offset + MemoryLayout<T>.size)
        }
        let value: T = try data.read(fromOffset: offset)
        offset += MemoryLayout<T>.size
        return numericCast(value)
    }
}
