//
//  DotView.swift
//  nRF-Connect
//  iOSCommonLibraries
//
//  Created by Dinesh Harjani on 15/11/23.
//  Copyright © 2025 Nordic Semiconductor. All rights reserved.
//

import SwiftUI

// MARK: - DotView

public struct DotView: View {
    
    // MARK: Environment
    
    @Environment(\.isEnabled) private var isEnabled
    
    // MARK: Private Properties
    
    private let color: Color
    
    // MARK: init
    
    public init(_ color: Color) {
        self.color = color
    }
    
    // MARK: view
    
    public var body: some View {
        Circle()
            .fill(isEnabled ? color : .disabledTextColor)
            .frame(width: 8.0, height: 8.0)
    }
}
