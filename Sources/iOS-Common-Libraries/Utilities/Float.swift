//
//  Float.swift
//  nRF-Connect
//  iOSCommonLibraries
//
//  Created by Dinesh Harjani on 20/11/2018.
//  Created by Dinesh Harjani on 19/3/25.
//

import Foundation

// MARK: - Float Extension

public extension Float {
    
    // MARK: init
    
    init(_ data: Data) {
        let tempData = data.littleEndianBytes(as: UInt32.self)
        var mantissa = Int32(tempData & 0x00FFFFFF)
        let exponent = Int8(bitPattern: UInt8(tempData >> 24))

        if mantissa >= Int32(0x007FFFFE) && mantissa <= Int32(0x00800002) {
            self = .nan
        } else {
            if mantissa >= 0x800000 {
                mantissa = -((0xFFFFFF + 1) - mantissa)
            }
            let magnitude = pow(10.0, Float(exponent))
            self = Float32(mantissa) * Float32(magnitude)
        }
    }
}
