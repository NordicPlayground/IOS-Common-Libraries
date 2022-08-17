//
//  ErrorEvent.swift
//  iOS-Common-Libraries
//
//  Created by Dinesh Harjani on 26/4/21.
//

import Foundation
import SwiftUI

// MARK: - ErrorEvent

public struct ErrorEvent: Error, Identifiable, Hashable {
    
    // MARK: Properties
    
    public let title: String
    public let localizedDescription: String
    
    public var id: Int {
        hashValue
    }
    
    // MARK: Init
    
    public init(_ error: Error) {
        self.init(title: "Error", localizedDescription: error.localizedDescription)
    }
    
    public init(title: String, localizedDescription: String) {
        self.title = title
        self.localizedDescription = localizedDescription
    }
    
    // MARK: Hashable
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(localizedDescription)
    }
}

// MARK: - Alert Extension

public extension Alert {
    
    init(errorEvent: ErrorEvent) {
        self.init(title: Text(errorEvent.title),
                  message: Text(errorEvent.localizedDescription))
    }
}
