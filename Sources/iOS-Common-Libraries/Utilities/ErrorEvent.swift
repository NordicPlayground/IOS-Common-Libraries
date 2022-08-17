//
//  ErrorEvent.swift
//  iOS-Common-Libraries
//
//  Created by Dinesh Harjani on 26/4/21.
//

import Foundation
import SwiftUI

// MARK: - ErrorEvent

struct ErrorEvent: Error, Identifiable, Hashable {
    
    // MARK: Properties
    
    let title: String
    let localizedDescription: String
    
    var id: Int {
        hashValue
    }
    
    // MARK: Init
    
    init(_ error: Error) {
        self.init(title: "Error", localizedDescription: error.localizedDescription)
    }
    
    init(title: String, localizedDescription: String) {
        self.title = title
        self.localizedDescription = localizedDescription
    }
    
    // MARK: Hashable
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(localizedDescription)
    }
}

// MARK: - Alert Extension

extension Alert {
    
    init(errorEvent: ErrorEvent) {
        self.init(title: Text(errorEvent.title),
                  message: Text(errorEvent.localizedDescription))
    }
}
