//
//  Optional.swift
//  iOS-Common-Libraries
//
//  Created by Dinesh Harjani on 8/5/24.
//  Copyright © 2018 Nordic Semiconductor. All rights reserved.
//

import Foundation

// MARK: - Optional nilDescription

extension Optional {

    public var nilDescription: String {
        guard let self else { return "nil" }
        return String(describing: self)
    }
}

extension Optional where Wrapped == Error {
    
    public var nilLocalizedDescription: String {
        guard let self else { return "nil" }
        return self.localizedDescription
    }
}
