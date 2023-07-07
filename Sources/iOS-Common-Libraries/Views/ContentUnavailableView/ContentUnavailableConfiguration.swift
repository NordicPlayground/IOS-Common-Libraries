//
//  File.swift
//  
//
//  Created by Nick Kibysh on 07/07/2023.
//

import SwiftUI

@available(iOS 15.0, *)
public struct ContentUnavailableConfiguration {
    @available(iOS 15.0, *)
    public struct ButtonConfiguration {
        public var title: any StringProtocol
        public var action: () -> Void
        public var style: any ButtonStyle
        
        public init(title: any StringProtocol, style: any ButtonStyle = NordicPrimary(), action: @escaping () -> Void) {
            self.title = title
            self.action = action
            self.style = style
        }
    }
    
    public var text: String?
    public var secondaryText: String?
    public var image: Image?
    public var buttonConfiguration: ButtonConfiguration?
    
    public var imageWidth: CGFloat
    public var imageHeight: CGFloat
    
    public var imageForegroundColor: Color
    
    public init(text: String? = nil, secondaryText: String? = nil, image: Image? = nil, buttonConfiguration: ButtonConfiguration? = nil, imageWidth: CGFloat = 200, imageHeight: CGFloat = 200, imageForegroundColor: Color = .secondary) {
        self.text = text
        self.secondaryText = secondaryText
        self.image = image
        self.buttonConfiguration = buttonConfiguration
        self.imageWidth = imageWidth
        self.imageHeight = imageHeight
        self.imageForegroundColor = imageForegroundColor
    }
    
    public init(text: String? = nil, secondaryText: String? = nil, systemName: String? = nil, buttonConfiguration: ButtonConfiguration? = nil, imageWidth: CGFloat = 200, imageHeight: CGFloat = 200, imageForegroundColor: Color = .secondary) {
        let image = systemName.map { Image(systemName: $0) }
        self.init(text: text, secondaryText: secondaryText, image: image, buttonConfiguration: buttonConfiguration, imageWidth: imageWidth, imageHeight: imageHeight, imageForegroundColor: imageForegroundColor)
    }
}
