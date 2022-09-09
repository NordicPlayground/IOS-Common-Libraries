//
//  RGB.swift
//  iOS-Common-Libraries
//
//  Created by Nick Kibysh on 28/06/2022.
//

import Foundation
import CoreGraphics

// MARK: - RGB

/**
 Goal of 'RGB' is to be as light as possible on resources. Hence why we're packing all R, G, B components into a single `UInt32`.
 
 Note that `Int` is the standard for Swift code, but it can be 32-bit or 64-bit depending on the platform.
 */
typealias RGB = UInt32

extension RGB {
    
    static let RGBMAX: RGB = 255
    static let RGBMAXf = CGFloat(RGBMAX)
    
    // MARK: Init
    
    init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        let redComponent = Int(red * Self.RGBMAXf)
        let greenComponent = Int(green * Self.RGBMAXf)
        let blueComponent = Int(blue * Self.RGBMAXf)
        self.init(red: redComponent, green: greenComponent, blue: blueComponent)
    }
    
    init(hex: Int) {
        let redComponent = (hex & 0xff_00_00) / 0x1_00_00
        let greenComponent = (hex & 0xff_00) / 0x1_00
        let blueComponent = (hex & 0xff)
        self.init(red: redComponent, green: greenComponent, blue: blueComponent)
    }
    
    init(red: UInt8, green: UInt8, blue: UInt8) {
        let redComponent = Int(red)
        let greenComponent = Int(green)
        let blueComponent = Int(blue)
        self.init(red: redComponent, green: greenComponent, blue: blueComponent)
    }
    
    init(red: Int, green: Int, blue: Int) {
        let components = [red, green, blue].map { UInt32($0) }
        components.forEach {
            assert(0...Self.RGBMAX ~= $0, "Invalid component of value \($0).")
        }
        self = (components[0] << 16) | (components[1] << 8) | components[2]
    }
    
    // MARK: Properties
    
    var red: Int {
        Int((self >> 16) & 0xFF)
    }
    
    var green: Int {
        Int((self >> 8) & 0xFF)
    }
    
    var blue: Int {
        Int(self & 0xFF)
    }
}
