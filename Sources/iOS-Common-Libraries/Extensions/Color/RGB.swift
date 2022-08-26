//
//  RGB.swift
//  iOS-Common-Libraries
//
//  Created by Nick Kibysh on 28/06/2022.
//

import Foundation

// MARK: - RGB

struct RGB {

    // MARK: Properties
    
    var red: Double
    var green: Double
    var blue: Double
    
    // MARK: Init

    /**
     Used by ´ExpressibleByIntegerLiteral´ protocol.
     */
    init(_ hex: Int) {
        let red = (hex & 0xff_00_00) / 0x1_00_00
        let green = (hex & 0xff_00) / 0x1_00
        let blue = (hex & 0xff)
        
        self.red = Double(red) / Double(0xff)
        self.green = Double(green) / Double(0xff)
        self.blue = Double(blue) / Double(0xff)
    }

    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }

    init(red: UInt8, green: UInt8, blue: UInt8) {
        let uint8ToDouble: (UInt8) -> (Double) = {
            Double($0) / Double(UInt8.max)
        }

        self.red = uint8ToDouble(red)
        self.green = uint8ToDouble(green)
        self.blue = uint8ToDouble(blue)
    }
}

// MARK: - ExpressibleByIntegerLiteral

extension RGB: ExpressibleByIntegerLiteral {
    
    public init(integerLiteral value: IntegerLiteralType) {
        self.init(value)
    }
}
