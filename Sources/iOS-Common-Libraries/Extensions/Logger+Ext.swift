//
//  Logger.swift
//  iOS-Common-Libraries
//
//  Created by Nick Kibysh on 12/04/2021.
//

import Foundation
import os

extension L {
    static let iOSCommonLibrarySubsystem = "com.nordicsemi.iOS-Common-Libraries"
    
    // MARK: - Init
    
    init(_ clazz: AnyClass) {
        self.init(category: String(describing: clazz))
    }
    
    init(category: String) {
        self.init(subsystem: L.iOSCommonLibrarySubsystem, category: category)
    }
}
