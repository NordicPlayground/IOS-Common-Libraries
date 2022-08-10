//
//  Constant.swift
//  iOS-Common-Libraries
//
//  Created by Dinesh Harjani on 9/8/22.
//

import Foundation

// MARK: - Constant

public enum Constant {
    
    // MARK: - Preview
    
    static public func isRunningInPreviewMode() -> Bool {
        return ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
    
    // MARK: - App
    
    static public let copyright: String = {
        return "Copyright © \(Date.currentYear()) Nordic Semiconductor ASA"
    }()
}
