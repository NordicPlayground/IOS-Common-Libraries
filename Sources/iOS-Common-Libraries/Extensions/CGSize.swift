//
//  CGSize.swift
//  iOSCommonLibraries
//
//  Created by Dinesh Harjani on 8/5/25.
//

import Foundation

// MARK: - CGSize Extension

public extension CGSize {
    
    // MARK: square init
    
    init(asSquare dimension: CGFloat) {
        self.init(width: dimension, height: dimension)
    }
}
