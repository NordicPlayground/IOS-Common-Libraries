//
//  Color.swift
//  iOS-Common-Libraries
//
//  Created by Dinesh Harjani on 10/8/22.
//

import SwiftUI

public extension Color {

    // MARK: uiColor
    
    #if os(iOS)
    var uiColor: UIColor {
        UIColor(self)
    }
    #endif
    
    // MARK: Other Color(s)
    
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
