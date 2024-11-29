//
//  IndeterminateProgressView.swift
//  nRF-Wi-Fi-Provisioner (iOS)
//  iOS-Common-Libraries
//
//  Created by Dinesh Harjani on 26/4/24.
//

import SwiftUI

// MARK: - IndeterminateProgressView

/**
 Source: https://matthewcodes.uk/articles/indeterminate-linear-progress-view/
 
 Code has been ammended by me since the capsule stopped moving across the entire available width.
 */
public struct IndeterminateProgressView: View {

    // MARK: Environment
    
    @Environment(\.isEnabled) private var isEnabled
    
    // MARK: Properties
    
    @State private var offset: CGFloat
   
    // MARK: init
    
    public init() {
        offset = 0.0
    }
    
    // MARK: view
    
    public var body: some View {
       GeometryReader { geometry in
           Rectangle()
               .foregroundColor(.gray.opacity(0.15))
               .overlay(
                Rectangle()
                    .foregroundColor(Color.accentColor)
                    .frame(width: geometry.size.width * 0.25, height: 6)
                    .clipShape(.capsule)
                    .offset(x: -geometry.size.width * 0.8 * offset, y: 0)
                    .offset(x: geometry.size.width * 0.6, y: 0)
                    .animation(.easeInOut.repeatForever().speed(0.23), value: offset)
                    .onAppear{
                        withAnimation {
                            offset = 1.5
                        }
                    }
               )
               .clipShape(.capsule)
               .opacity(isEnabled ? 1 : 0)
               .animation(.default, value: isEnabled)
               .frame(height: 6)
       }
   }
}
