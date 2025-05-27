//
//  CommonDataParser+Foundation.swift
//  nRF-Connect
//  iOSCommonLibraries
//
//  Created by Dinesh Harjani on 25/3/22.
//  Created by Dinesh Harjani on 27/5/25.
//  Copyright © 2025 Nordic Semiconductor. All rights reserved.
//

import Foundation

public extension CommonDataParser {
    
    // MARK: ByteArray
    
    static var ByteArray: Self {
        CommonDataParser(name: #function, description: "Byte Array (Hex)", parse: { data in
            guard !data.isEmpty else { return "" }
            return data.hexEncodedString(options: [.twoByteSpacing, .upperCase])
        })
    }
    
    // MARK: UnsignedInt
    
    internal static let UnsignedIntSupportedSizes = [MemoryLayout<UInt8>.size, MemoryLayout<UInt16>.size, MemoryLayout<UInt32>.size]
    static var UnsignedInt: Self {
        CommonDataParser(name: #function, description: "Unsigned Int (8, 16 or 32)", meetsMinSize: { byteCount in
            return UnsignedIntSupportedSizes.contains(byteCount)
        }, parse: { data in
            let intValue: Int
            switch data.count {
            case MemoryLayout<UInt8>.size:
                intValue = data.littleEndianBytes(as: UInt8.self)
            case MemoryLayout<UInt16>.size:
                intValue = data.littleEndianBytes(as: UInt16.self)
            case MemoryLayout<UInt32>.size:
                intValue = data.littleEndianBytes(as: UInt32.self)
            default:
                return nil
            }
            return String(intValue)
        })
    }
    
    // MARK: SignedInt
    
    internal static let SignedIntSupportedSizes = [MemoryLayout<Int8>.size, MemoryLayout<Int16>.size, MemoryLayout<Int32>.size]
    static var SignedInt: Self {
        CommonDataParser(name: #function, description: "Signed Int (8, 16 or 32)", meetsMinSize: { bytes in
            return SignedIntSupportedSizes.contains(bytes)
        }, parse: { data in
            let intValue: Int
            switch data.count {
            case MemoryLayout<Int8>.size:
                intValue = data.littleEndianBytes(as: Int8.self)
            case MemoryLayout<Int16>.size:
                intValue = data.littleEndianBytes(as: Int16.self)
            case MemoryLayout<Int32>.size:
                intValue = data.littleEndianBytes(as: Int32.self)
            default:
                return nil
            }
            return String(intValue)
        })
    }
    
    // MARK: Bool
    
    static var Bool: Self {
        CommonDataParser(name: #function, description: "Boolean", meetsMinSize: { size in
            return size == MemoryLayout<Int8>.size
        }, parse: { data in
            let intValue = data.littleEndianBytes(as: Int8.self)
            let bool = intValue > 0
            return bool ? "True" : "False"
        })
    }
    
    // MARK: - UTF8
    
    static var UTF8: Self {
        CommonDataParser(name: #function, description: "UTF-8", parse: { data in
            String(data: data, encoding: .utf8) as String?
        })
    }
}
