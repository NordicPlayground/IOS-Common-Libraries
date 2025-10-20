//
//  Color.swift
//  iOS-Common-Libraries
//
//  Created by Nick Kibysh on 28/06/2022.
//  Created by Dinesh Harjani on 10/8/22.
//

import SwiftUI

#if os(macOS)
public typealias SysColor = NSColor
#elseif os(iOS)
public typealias SysColor = UIColor
#endif

public extension Color {

    // MARK: Init
    
    init(rgba: RGBA) {
        self.init(SysColor(rgba: rgba))
    }
    
    init(light: RGBA, dark: RGBA) {
        self.init(SysColor(light: light, dark: dark))
    }
    
    init(red: UInt8, green: UInt8, blue: UInt8) {
        self.init(red: Double(red) / Double(UInt8.max),
                  green: Double(green) / Double(UInt8.max),
                  blue: Double(blue) / Double(UInt8.max))
    }
    
    // MARK: uiColor
    
    #if os(iOS) || targetEnvironment(macCatalyst)
    var uiColor: UIColor {
        UIColor(self)
    }
    #endif
    
    // MARK: Nordic
    
    /**
     Primary Color.
    */
    static let nordicBlue = Color(red: 0, green: 169, blue: 206)
    /**
     Primary Color.
     */
    static let nordicSky = Color(red: 106, green: 209, blue: 27)
    /**
     Primary Color.
     */
    static let nordicBlueslate = Color(red: 0, green: 50, blue: 160)
    /**
     Primary Color.
     */
    static let nordicLake = Color(red: 0, green: 119, blue: 200)
    
    /**
     nRF51 Series.
    */
    static let nordicGrass = Color(red: 206, green: 221, blue: 80)
    /**
     nRF52 Series.
     */
    static let nordicSun = Color(red: 244, green: 203, blue: 67)
    /**
     nRF91 Series.
     */
    static let nordicFall = Color(red: 222, green: 130, blue: 59)
    /**
     nPM Family.
     */
    static let nordicPower = Color(red: 139, green: 192, blue: 88)
    /**
     nRF53 Series.
     */
    static let nordicRed = Color(red: 209, green: 49, blue: 79)
    /**
     nRF21 Series.
     */
    static let nordicPink = Color(red: 198, green: 0, blue: 126)
    
    /**
     Neutral Color.
     */
    static let nordicLightGrey = Color(red: 217, green: 225, blue: 226)
    /**
     Neutral Color.
     */
    static let nordicMiddleGrey = Color(red: 118, green: 134, blue: 146)
    /**
     Neutral Color.
     */
    static let nordicDarkGrey = Color(red: 51, green: 63, blue: 72)
    
    // MARK: Label Color(s)
    
    static var primarylabel: Color {
        #if os(OSX)
        return Color(nsColor: .labelColor)
        #elseif os(iOS)
        if #available(iOS 15.0, macCatalyst 15.0, macOS 12.0, *) {
            return Color(uiColor: UIColor.label)
        } else {
            return Color.primary
        }
        #endif
    }
    
    static var secondarylabel: Color {
        #if os(OSX)
        return Color(nsColor: .secondaryLabelColor)
        #elseif os(iOS)
        if #available(iOS 15.0, macCatalyst 15.0, macOS 12.0, *) {
            return Color(uiColor: UIColor.secondaryLabel)
        } else {
            return Color.secondary
        }
        #endif
    }

    static var tertiarylabel: Color {
        #if os(OSX)
        return Color(nsColor: .tertiaryLabelColor)
        #elseif os(iOS)
        if #available(iOS 15.0, macCatalyst 15.0, macOS 12.0, *) {
            return Color(uiColor: UIColor.tertiaryLabel)
        } else {
            return Color.secondary.opacity(0.9)
        }
        #endif
    }
    
    static var quaternaryLabel: Color {
        #if os(OSX)
        return Color(nsColor: .quaternaryLabelColor)
        #elseif os(iOS)
        if #available(iOS 15.0, macCatalyst 15.0, macOS 12.0, *) {
            return Color(uiColor: UIColor.quaternaryLabel)
        } else {
            return Color.secondary.opacity(0.7)
        }
        #endif
    }
    
    // MARK: Other Color(s)
    
    static var navigationBarBackground: Color {
        Color(light: 0x00a9ce, dark: RGBA(0x333F48))
    }
    
    static var universalAccentColor: Color {
        #if os(OSX) || targetEnvironment(macCatalyst)
        return .accentColor
        #elseif os(iOS)
        return .nordicBlue
        #endif
    }
    
    static var positiveActionButtonColor: Color {
        #if os(OSX)
        return .primary
        #elseif os(iOS)
        return .nordicBlue
        #endif
    }
    
    static var negativeActionButtonColor: Color { .nordicRed }
    
    static var succcessfulActionButtonColor: Color { .nordicBlue }
    
    static var disabledTextColor: Color { .nordicMiddleGrey }
    
    static var textFieldColor: Color {
        #if os(OSX)
        return Color.primary
        #elseif os(iOS)
        return Color(.black)
        #endif
    }
    
    static var formBackground: Color {
        #if os(OSX)
        return .clear
        #elseif os(iOS)
        return Color(UIColor.systemGroupedBackground)
        #endif
    }
    
    static var secondarySystemBackground: Color {
        #if os(OSX)
        return Color(.controlBackgroundColor)
        #elseif os(iOS)
        return Color(UIColor.secondarySystemBackground)
        #endif
    }
    
    static var secondarySystemGroupBackground: Color {
        #if os(OSX)
        return Color(.controlBackgroundColor)
        #elseif os(iOS)
        return Color(UIColor.secondarySystemGroupedBackground)
        #endif
    }
}
