//
//  NordicLog.swift
//  iOS-Common-Libraries
//
//  Created by Nick Kibysh on 12/04/2021.
//  Created by Dinesh Harjani on 21/03/2019.
//  Copyright © 2019 Nordic Semiconductor. All rights reserved.
//

import Foundation
import os
import MetricKit
#if canImport(UIKit)
import UIKit
#endif

// MARK: - NordicLog Definition

public struct NordicLog {

    static let iOSCommonLibrarySubsystem = "com.nordicsemi.iOS-Common-Libraries"
    
    // MARK: Private Properties

    private let category: String
    private let subsystem: String
    
    private let logger: Logger
    private let poiLog: OSLog
    private let mxLog: OSLog
    private let delegate: Delegate?

    // MARK: Init
    
    public init(_ object: AnyObject, subsystem: String, delegate: Delegate? = nil) {
        // Remove bundleName and clean UIView descriptions.
        let category = Self.cleanObjectName(object)
        self.init(category: category, subsystem: subsystem, delegate: delegate)
    }
    
    public init(_ clazz: AnyClass, subsystem: String, delegate: Delegate? = nil) {
        self.init(category: String(describing: clazz), subsystem: subsystem, delegate: delegate)
    }

    public init(category: String, subsystem: String, delegate: Delegate? = nil) {
        self.category = category
        self.subsystem = subsystem
        logger = Logger(subsystem: subsystem, category: category)
        poiLog = OSLog(subsystem: subsystem, category: .pointsOfInterest)
        mxLog = MXMetricManager.makeLogHandle(category: category)
        self.delegate = delegate
    }
    
    // MARK: cleanObjectName
    
    private static func cleanObjectName(_ object: AnyObject) -> String {
        switch object {
        case is UIView:
            return "\(object)"
                .components(separatedBy: ".").last?
                .components(separatedBy: ";").first
            ?? "\(object)"
        case is NSObject:
            return "\(object)".components(separatedBy: ".").last ?? "\(object)"
        default:
            let objectName = "\(object)"
                .components(separatedBy: ".").last
            ?? "\(object)"
            let pointerString = Unmanaged.passUnretained(object).toOpaque().debugDescription
            return "\(objectName) <\(pointerString)>"
        }
    }
}

// MARK: - Delegate

public extension NordicLog {
    
    protocol Delegate {
        func submitted(line: String, from category: String, subsystem: String,
                       as type: OSLogType)
    }
}

// MARK: - Logging API Extension

public extension NordicLog {

    @inline(__always) func info(_ line: String) {
        logger.info("\(line, privacy: .public)")
        mxEvent(name: #function, line: line)
        delegate?.submitted(line: line, from: category, subsystem: subsystem, as: .info)
    }

    @inline(__always) func debug(_ line: String) {
        logger.debug("\(line, privacy: .public)")
        mxEvent(name: #function, line: line)
        delegate?.submitted(line: line, from: category, subsystem: subsystem, as: .debug)
    }

    @inline(__always) func error(_ line: String) {
        logger.error("\(line, privacy: .public)")
        mxEvent(name: #function, line: line)
        delegate?.submitted(line: line, from: category, subsystem: subsystem, as: .error)
    }
}

// MARK: - Signpost API Extension

public extension NordicLog {

    @inline(__always) private func mxEvent(name: StaticString, line: String) {
        #if os(iOS) || targetEnvironment(macCatalyst)
        mxSignpost(.event, log: mxLog, name: name, signpostID: OSSignpostID(log: mxLog), "%{PUBLIC}@", [line])
        #endif
    }
    
    @inline(__always) func signpostStart(name: StaticString, object: AnyObject? = nil, description: String? = nil) {
        if let object {
            let signpostId = OSSignpostID(log: poiLog, object: object)
            if let description {
                os_signpost(.begin, log: poiLog, name: name, signpostID: signpostId, "%s", description)
            } else {
                os_signpost(.begin, log: poiLog, name: name, signpostID: signpostId)
            }
            #if os(iOS) || targetEnvironment(macCatalyst)
            mxSignpost(.begin, log: mxLog, name: name, signpostID: signpostId)
            #endif
        } else {
            os_signpost(.begin, log: poiLog, name: name)
            #if os(iOS) || targetEnvironment(macCatalyst)
            mxSignpost(.begin, log: mxLog, name: name)
            #endif
        }
    }

    @inline(__always) func signpostEnd(name: StaticString, object: AnyObject? = nil, description: String? = nil) {
        if let object {
            let signpostId = OSSignpostID(log: poiLog, object: object)
            if let description {
                os_signpost(.end, log: poiLog, name: name, signpostID: signpostId, "%s", description)
            } else {
                os_signpost(.end, log: poiLog, name: name, signpostID: signpostId)
            }
            #if os(iOS) || targetEnvironment(macCatalyst)
            mxSignpost(.end, log: mxLog, name: name, signpostID: signpostId)
            #endif
        } else {
            os_signpost(.end, log: poiLog, name: name)
            #if os(iOS) || targetEnvironment(macCatalyst)
            mxSignpost(.end, log: mxLog, name: name)
            #endif
        }
    }
}
