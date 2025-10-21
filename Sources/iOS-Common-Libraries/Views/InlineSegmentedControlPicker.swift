//
//  InlineSegmentedControlPicker.swift
//  nRF-Connect
//  iOSCommonLibraries
//
//  Created by Dinesh Harjani on 15/3/23.
//  Copyright © 2023 Nordic Semiconductor. All rights reserved.
//

import SwiftUI

// MARK: - InlineSegmentedControlPicker

@available(iOS 14.0, macCatalyst 14.0, macOS 11.0, *)
public struct InlineSegmentedControlPicker<T: Hashable & Equatable & CustomStringConvertible>: View {
    
    // MARK: Properties
    
    private let selectedValue: Binding<T>
    private let possibleValues: [T]
    
    // MARK: Init
    
    public init(selectedValue: Binding<T>, possibleValues: [T]) {
        self.selectedValue = selectedValue
        self.possibleValues = possibleValues
    }
    
    // MARK: View
    
    public var body: some View {
        Picker("", selection: selectedValue) {
            ForEach(possibleValues, id: \.self) { value in
                Text(value.description)
                    .tag(value)
            }
        }
        .setAsSegmentedControlStyle()
    }
}
