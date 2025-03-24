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
    
    static public func bundleName(forBundleWithClass anyClass: AnyClass) -> String {
        return Bundle(for: anyClass).object(forInfoDictionaryKey: "CFBundleName") as? String
                ?? "N/A"
    }
    
    static public func appName(forBundleWithClass anyClass: AnyClass) -> String {
        return Bundle(for: anyClass).object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
                ?? "N/A"
    }
    
    static public func appVersion(forBundleWithClass anyClass: AnyClass) -> String {
        guard let versionNumber = Bundle(for: anyClass).object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String,
              let buildNumber = Bundle(for: anyClass).object(forInfoDictionaryKey: "CFBundleVersion") as? String else {
            return "N/A"
        }
        return "\(versionNumber) (#\(buildNumber))"
    }
    
    static public let copyright: String = {
        return "Copyright © \(Date.currentYear()) Nordic Semiconductor ASA"
    }()
}
