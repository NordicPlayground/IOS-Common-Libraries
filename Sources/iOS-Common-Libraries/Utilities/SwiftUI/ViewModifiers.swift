//
//  ViewModifiers.swift
//  nRF-Edge-Impulse
//  iOS-Common-Libraries
//
//  Created by Dinesh Harjani on 15/6/21.
//

import SwiftUI

// MARK: - RoundedTextFieldShape

public struct RoundedTextFieldShape: ViewModifier {
    
    private let backgroundColor: Color
    private let hasTextFieldBelow: Bool
    
    public init(_ backgroundColor: Color, hasTextFieldBelow: Bool = false) {
        self.backgroundColor = backgroundColor
        self.hasTextFieldBelow = hasTextFieldBelow
    }
    
    public func body(content: Content) -> some View {
        content
        #if os(iOS)
            .frame(maxWidth: 320)
            .frame(height: 20)
            .padding()
            .background(backgroundColor)
            .cornerRadius(30)
            .padding(.bottom, hasTextFieldBelow ? 16 : 0)
        #endif
    }
}
