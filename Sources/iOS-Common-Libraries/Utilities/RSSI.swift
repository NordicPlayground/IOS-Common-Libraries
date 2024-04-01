//
//  RSSI.swift
//  iOS-Common-Libraries
//
//  Created by Nick Kibysh on 20/07/2022.
//  Created by Dinesh Harjani on 11/08/2020.
//  Copyright © 2020 Nordic Semiconductor. All rights reserved.
//

import SwiftUI

// MARK: - RSSI

public enum RSSI: Int, Equatable, CaseIterable {
    case outOfRange = 127
    case practicalBest = -20
    case practicalWorst = -100
    case bad
    case ok
    case good
    
    public var color: Color {
        switch self {
        case .good, .practicalBest:
            return .green
        case .ok:
            return .yellow
        case .bad:
            return .orange
        case .outOfRange:
            return .red
        case .practicalWorst:
            return .red
        }
    }
    
    public var numberOfBars: Int {
        switch self {
        case .good, .practicalBest:
            return 4
        case .ok:
            return 3
        case .bad:
            return 2
        case .practicalWorst:
            return 1
        case .outOfRange:
            return 0
        }
    }
}
