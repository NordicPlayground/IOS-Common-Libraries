//
//  BadgeView.swift
//  iOSCommonLibraries
//  nRF-Toolbox
//
//  Created by Nick Kibysh on 10/07/2023.
//  Created by Dinesh Harjani on 10/4/25.
//  Copyright © 2025 Nordic Semiconductor. All rights reserved.
//

import SwiftUI

// MARK: - BadgeView

struct BadgeView: View {
    
    // MARK: Private Properties
    
    private let image: Image?
    private let name: String
    private let color: Color
    
    // MARK: init
    
    init(image: Image?, name: String, color: Color) {
        self.image = image
        self.name = name
        self.color = color
    }
    
    init(name: String) {
        self.image = nil
        self.name = name
        self.color = .secondary
    }
    
    // MARK: view
    
    var body: some View {
        HStack {
            image?
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 12, maxHeight: 12)
                .foregroundColor(color)
            
            Text(name)
                .foregroundColor(.secondary)
                .font(.caption)
        }
        .padding(EdgeInsets(top: 2, leading: 5, bottom: 2, trailing: 5))
        .background(.blue.opacity(0.15))
        .cornerRadius(6)
    }
}
