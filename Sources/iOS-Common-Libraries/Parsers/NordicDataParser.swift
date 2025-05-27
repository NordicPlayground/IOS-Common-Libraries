//
//  NordicDataParser.swift
//  nRF-Connect
//  iOSCommonLibraries
//
//  Created by Dinesh Harjani on 28/01/2019.
//  Created by Dinesh Harjani on 27/5/25.
//  Copyright © 2025 Nordic Semiconductor. All rights reserved.
//

import Foundation

// MARK: - NordicDataParser

public protocol NordicDataParser: Hashable, Equatable, CustomStringConvertible {
    
    // MARK: Properties
    
    var description: String { get }
    
    // MARK: API
    
    func callAsFunction(_ item: Data) -> String?
    
    func isValidDataLength(_ data: Data) -> Bool
}

