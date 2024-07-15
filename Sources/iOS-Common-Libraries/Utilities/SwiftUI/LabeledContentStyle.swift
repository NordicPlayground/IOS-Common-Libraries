//
//  LabeledContentStyle.swift
//  nRF-Connect
//  iOS-Common-Libraries
//
//  Created by Dinesh Harjani on 29/11/22.
//  Copyright © 2022 Nordic Semiconductor. All rights reserved.
//

import SwiftUI

// MARK: - AccentedContent

@available(iOS 16.0, macCatalyst 16.0, macOS 13.0, *)
public struct AccentedContentLabeledContentStyle: LabeledContentStyle {
    
    // MARK: Private Properties
    
    private let accentColor: Color
    private let labelFont: Font?
    private let lineLimit: Int
    
    // MARK: Init
    
    init(accentColor: Color = Color.universalAccentColor, labelFont: Font? = nil, lineLimit: Int = 1) {
        self.accentColor = accentColor
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
                    .setAccent(accentColor)
                    .foregroundColor(accentColor)
            } label: {
                configuration.label
                    .font(labelFont)
                    .foregroundColor(textColor)
            }
        } else {
            LabeledContent {
                configuration.content
                    .font(labelFont)
                    .setAccent(accentColor)
                    .foregroundColor(accentColor)
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
public extension LabeledContentStyle where Self == AccentedContentLabeledContentStyle {
    
    static var accentedContent: AccentedContentLabeledContentStyle { .init() }
    
    static func accentedContent(accentColor: Color = .universalAccentColor, labelFont: Font? = nil, lineLimit: Int = 1) -> AccentedContentLabeledContentStyle {
        AccentedContentLabeledContentStyle(accentColor: accentColor, labelFont: labelFont, lineLimit: lineLimit)
    }
}
