//
//  Data.swift
//  
//
//  Created by Dinesh Harjani on 18/8/22.
//  Copyright © 2020 Nordic Semiconductor. All rights reserved.
//

import Foundation

// MARK: - Byte Handling

public extension Data {
    
    func canRead<T: FixedWidthInteger>(_ dataType: T.Type, atOffset offset: Int) -> Bool {
        return offset + MemoryLayout<T>.size <= count
    }
    
    func littleEndianBytes<T: FixedWidthInteger>(atOffset offset: Int = 0, as: T.Type) -> Int {
        let byteLength = MemoryLayout<T>.size
        return subdata(in: offset ..< offset + byteLength).withUnsafeBytes { Int($0.load(as: T.self)) }
    }

    func bigEndianBytes<T: FixedWidthInteger>(atOffset offset: Int = 0, as: T.Type) -> Int {
        let byteLength = MemoryLayout<T>.size
        return subdata(in: offset ..< offset + byteLength).withUnsafeBytes { Int(T(bigEndian: $0.load(as: T.self))) }
    }
}

// MARK: - Hex Encoding

public extension Data {
    
    // MARK: HexEncodingOptions
    
    struct HexEncodingOptions: OptionSet {
        
        public static let upperCase = HexEncodingOptions(rawValue: 1)
        public static let reverseEndianness = HexEncodingOptions(rawValue: 2)
        
        public let rawValue: Int
        
        public init(rawValue: Int) {
            self.rawValue = rawValue << 0
        }
    }

    // MARK: hexEncodedString
    
    func hexEncodedString(options: HexEncodingOptions = [], separator: String = "") -> String {
        let format = options.contains(.upperCase) ? "%02hhX" : "%02hhx"
        
        var bytes = self
        if options.contains(.reverseEndianness) {
            bytes.reverse()
        }
        return bytes
            .map { String(format: format, $0) }
            .joined(separator: separator)
    }
}
