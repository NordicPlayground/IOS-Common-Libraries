//
//  LabeledContentStyle.swift
//  nRF-Connect
//  iOS-Common-Libraries
//
//  Created by Dinesh Harjani on 29/11/22.
//  Copyright © 2022 Nordic Semiconductor. All rights reserved.
//

import SwiftUI

// MARK: - Accented

@available(iOS 16.0, macCatalyst 16.0, macOS 13.0, *)
public struct AccentedLabeledContentStyle: LabeledContentStyle {
    
    // MARK: Private Properties
    
    private let labelFont: Font?
    private let lineLimit: Int
    
    // MARK: Init
    
    init(labelFont: Font? = nil, lineLimit: Int = 1) {
        self.labelFont = labelFont
        self.lineLimit = lineLimit
    }
    
    // MARK: Properties
    
    @Environment(\.colorScheme) var colorScheme
    private var textColor: Color {
        switch colorScheme {
        case .dark:
            return .white
        default:
            return .black
        }
    }
    
    // MARK: Body
    
    @ViewBuilder
    public func makeBody(configuration: Configuration) -> some View {
        if lineLimit < 1 {
            LabeledContent {
                configuration.content
                    .font(labelFont)
                    .setAccent(Color.universalAccentColor)
                    .foregroundColor(Color.universalAccentColor)
            } label: {
                configuration.label
                    .font(labelFont)
                    .foregroundColor(textColor)
            }
        } else {
            LabeledContent {
                configuration.content
                    .font(labelFont)
                    .setAccent(.universalAccentColor)
                    .foregroundColor(.universalAccentColor)
            } label: {
                configuration.label
                    .font(labelFont)
                    .foregroundColor(textColor)
            }
            .lineLimit(lineLimit)
        }
    }
}

// MARK: - LabeledContentStyle

@available(iOS 16.0, macCatalyst 16.0, macOS 13.0, *)
public extension LabeledContentStyle where Self == AccentedLabeledContentStyle {
    
    static var accented: AccentedLabeledContentStyle { .init() }
    
    static func accented(labelFont: Font? = nil, lineLimit: Int = 1) -> AccentedLabeledContentStyle {
        AccentedLabeledContentStyle(labelFont: labelFont, lineLimit: lineLimit)
    }
}
