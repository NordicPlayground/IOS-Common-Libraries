//
//  NSColor.swift
//  iOS-Common-Libraries
//
//  Created by Dinesh Harjani on 25/8/22.
//

#if os(macOS)
import AppKit

// MARK: - NSColor

extension NSColor {
    
    public convenience init(rgba: RGBA) {
        self.init(red: rgba.red, green: rgba.green, blue: rgba.blue, alpha: rgba.alpha)
    }
    
    public convenience init(light: RGBA, dark: RGBA) {
        self.init(name: nil) { appearance in
            appearance.name.isDark ? NSColor(rgba: dark) : NSColor(rgba: light)
        }
    }
}

// MARK: - NSAppearance

extension NSAppearance.Name {
    
    public var isDark: Bool {
        self == .darkAqua || self == .vibrantDark || self == .accessibilityHighContrastDarkAqua || self == .accessibilityHighContrastVibrantDark
    }
}

#endif
