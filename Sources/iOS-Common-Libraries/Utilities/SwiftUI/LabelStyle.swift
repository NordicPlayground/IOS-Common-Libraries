//
//  LabelStyle.swift
//  iOS-Common-Libraries
//
//  Created by Dinesh Harjani on 15/5/24.
//

import SwiftUI

// MARK: - ColorIconOnlyLabelStyle

public struct ColorIconOnlyLabelStyle: LabelStyle {
    
    let iconColor: Color
    
    @Environment(\.isEnabled) private var isEnabled
    
    public func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .firstTextBaseline) {
            configuration.icon
                .foregroundColor(isEnabled ? iconColor : .disabledTextColor)
            
            configuration.title
        }
    }
}

public extension LabelStyle where Self == ColorIconOnlyLabelStyle {
    
    static func colorIconOnly(_ color: Color) -> ColorIconOnlyLabelStyle {
        return ColorIconOnlyLabelStyle(iconColor: color)
    }
}
