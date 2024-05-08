//
//  InlinePicker.swift
//  nRF-Connect
//  iOS-Common-Libraries
//
//  Created by Dinesh Harjani on 13/3/23.
//  Copyright © 2023 Nordic Semiconductor. All rights reserved.
//

import SwiftUI

// MARK: - InlinePicker

@available(iOS 16.0, macCatalyst 16.0, macOS 13.0, *)
public struct InlinePicker<T: Hashable & Equatable>: View {
    
    public typealias OnChange = (T) -> Void
    
    // MARK: Properties
    
    private let title: String
    private let selectedValue: Binding<T>
    private let possibleValues: [T]
    private let onChange: OnChange?
    
    // MARK: Init
    
    init(title: String, selectedValue: Binding<T>, possibleValues: [T], onChange: OnChange? = nil) {
        self.title = title
        self.selectedValue = selectedValue
        self.possibleValues = possibleValues
        self.onChange = onChange
    }
    
    // MARK: View
    
    public var body: some View {
        LabeledContent(title) {
            Picker("", selection: selectedValue) {
                ForEach(possibleValues, id: \.self) { value in
                    Text((value as? CustomDebugStringConvertible)?.debugDescription ?? (value as? CustomStringConvertible).nilDescription)
                        .tag(value)
                }
            }
            .onChange(of: selectedValue.wrappedValue, perform: { newValue in
                onChange?(newValue)
            })
            .pickerStyle(.menu)
        }
        .labeledContentStyle(.accented(lineLimit: 0))
    }
}
