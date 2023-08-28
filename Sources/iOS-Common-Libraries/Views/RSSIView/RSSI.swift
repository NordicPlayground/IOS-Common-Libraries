//
//  File.swift
//  
//
//  Created by Nick Kibysh on 10/07/2023.
//

import Foundation

public enum SignalQuality {
    case good, ok, bad, outOfRange, practicalWorst
}

public protocol SignalQualytiConvertable {
    var signalQuality: SignalQuality { get }
}

public struct BluetoothRSSI: SignalQualytiConvertable {
    public let rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public var signalQuality: SignalQuality {
        switch self.rawValue {
        case 5...: return .outOfRange
        case (-60)...: return .good
        case (-90)...: return .ok
        case (-100)...: return .bad
        default: return .practicalWorst
        }
    }
}
