//
//  NoContentView.swift
//  nRF-Toolbox
//  iOSCommonLibraries
//
//  Created by Nick Kibysh on 06/11/2023.
//  Created by Dinesh Harjani on 26/3/25.
//  Copyright © 2023 Nordic Semiconductor. All rights reserved.
//

import SwiftUI

// MARK: - NoContentView

@available(iOS 17.0, macCatalyst 17.0, macOS 14.0, *)
public struct NoContentView: View {
    
    // MARK: Style
    
    public enum Style {
        case normal, tinted, error
        
        var tintColor: Color {
            switch self {
            case .normal:
                return .secondary
            case .tinted:
                return .nordicBlue
            case .error:
                return .nordicRed
            }
        }
    }
    
    // MARK: Private Properties
    
    private let text: Text
    private let image: Image
    private let description: String?
    private let style: Style
    private let animated: Bool
    
    @State private var rotationAngle = 0.0
    
    // MARK: init
    
    public init(title: String, systemImage: String, description: String? = nil,
                style: Style = .normal, animated: Bool = true) {
        self.init(text: Text(title), image: Image(systemName: systemImage), description: description, style: style, animated: animated)
    }
    
    public init(text: Text, image: Image, description: String? = nil,
                style: Style = .normal, animated: Bool = true) {
        self.text = text
        self.image = image
        self.description = description
        self.style = style
        self.animated = animated
    }
    
    // MARK: view
    
    public var body: some View {
        VStack {
            ContentUnavailableView {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(size: CGSize(asSquare: 60.0))
                    .foregroundStyle(style.tintColor)
                    .rotationEffect(Angle.degrees(rotationAngle))
                    .onAppear {
                        guard animated else { return }
                        startAnimations()
                    }
                
                text
                    .font(.title)
                    .bold()
            } description: {
                Text(description ?? "")
                    .font(.callout)
            }
        }
        .padding()
    }
    
    // MARK: Animation
    
    private func startAnimations() {
        withAnimation(.easeInOut(duration: 0.8)) {
            rotationAngle = -15.0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            withAnimation(.easeInOut(duration: 0.8)) {
                rotationAngle = 45.0
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
            withAnimation(.easeInOut(duration: 0.8)) {
                rotationAngle = 0.0
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
                startAnimations()
            }
        }
    }
}
