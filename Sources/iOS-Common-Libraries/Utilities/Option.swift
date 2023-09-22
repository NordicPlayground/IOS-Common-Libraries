//
//  Option.swift
//  iOS-Common-Libraries
//
//  Created by Dinesh Harjani on 22/9/23.
//  Copyright © 2019 Nordic Semiconductor. All rights reserved.
//

import Foundation

// MARK: - Option

/**
 Initially based upon and expanded from NSHipster's OptionSet.
 
 See: `https://nshipster.com/optionset/`
 */
public protocol Option: RawRepresentable, Hashable, CaseIterable {}

// MARK: - @bitwiseValue

public typealias RegisterValue = UInt
public extension Option where RawValue == RegisterValue {
    
    var bitwiseValue: RegisterValue { 1 << rawValue }
}
