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
    
    enum HexEncodingOptions: RegisterValue, Option {
        case upperCase
        case byteSpacing
        case prepend0x
        case twoByteSpacing
        case reverseEndianness
    }

    // MARK: hexEncodedString
    
    func hexEncodedString(options: BitField<HexEncodingOptions> = [], separator: String = "") -> String {
        guard !isEmpty else { return "0 bytes" }
        
        var format = options.contains(.upperCase) ? "%02hhX" : "%02hhx"
        if options.contains(.byteSpacing) {
            format.append(" ")
        }

        var bytes = self
        if options.contains(.reverseEndianness) {
            bytes.reverse()
        }
        var body: String = options.contains(.prepend0x) ? "0x" : ""
        if options.contains(.byteSpacing) {
            body.reserveCapacity(
                options.contains(.prepend0x) ? 1 : 0 + bytes.count * 3
            )
        } else {
            body.reserveCapacity(
                options.contains(.prepend0x) ? 1 : 0 + bytes.count * 2
            )
        }
        
        autoreleasepool {
            body.append(contentsOf: bytes.map {
                String(format: format, $0)
            }.joined())
        }
        
        if options.contains(.twoByteSpacing) {
            autoreleasepool {
                body = body.inserting(separator: " ", every: 4)
            }
        }

        return body
    }
}
