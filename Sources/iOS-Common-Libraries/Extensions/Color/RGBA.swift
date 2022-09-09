//
//  RGBA.swift
//  iOS-Common-Libraries
//
//  Created by Nick Kibysh on 28/06/2022.
//

import Foundation

// MARK: - RGBA

public struct RGBA {

    // MARK: Public Properties
    
    public var red: Double { Double(rgb.red) / Double(RGB.RGBMAX) }
    public var green: Double { Double(rgb.green) / Double(RGB.RGBMAX) }
    public var blue: Double { Double(rgb.blue) / Double(RGB.RGBMAX) }
    public var alpha: Double
    
    // MARK: Private Properties
    
    private var rgb: RGB
    
    // MARK: Init

    /**
     Used by ´ExpressibleByIntegerLiteral´ protocol.
     */
    init(_ hex: Int, alpha: Double = 1) {
        rgb = RGB(hex)
        self.alpha = alpha
    }

    init(red: Double, green: Double, blue: Double, alpha: Double = 1) {
        self.rgb = RGB(red: red, green: green, blue: blue)
        self.alpha = alpha
    }

    init(red: UInt8, green: UInt8, blue: UInt8, alpha: Double = 1) {
        self.rgb = RGB(red: red, green: green, blue: blue)
        self.alpha = alpha
    }
}

// MARK: - ExpressibleByIntegerLiteral

extension RGBA: ExpressibleByIntegerLiteral {
    
    public init(integerLiteral value: IntegerLiteralType) {
        self.init(value)
    }
}
