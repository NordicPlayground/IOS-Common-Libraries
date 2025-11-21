//
//  NetworkResponse.swift
//  iOSCommonLibraries
//
//  Created by Dinesh Harjani on 3/11/25.
//  Copyright © 2025 Nordic Semiconductor. All rights reserved.
//

import Foundation

// MARK: - NetworkResponse

public struct NetworkResponse {
    
    // MARK: Public Properties
    
    public let code: Int
    public let data: Data
    
    // MARK: init
    
    init(code: Int, data: Data) {
        self.code = code
        self.data = data
    }
}
