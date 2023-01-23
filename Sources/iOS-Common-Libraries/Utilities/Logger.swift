//
//  File.swift
//  
//
//  Created by Nick Kibysh on 20/01/2023.
//

import Foundation
import os

private protocol LoggMessageProtocol {
    func n(_ message: String, isPublic: Bool)
    func d(_ message: String, isPublic: Bool)
    func t(_ message: String, isPublic: Bool)
    func i(_ message: String, isPublic: Bool)
    func e(_ message: String, isPublic: Bool)
    func w(_ message: String, isPublic: Bool)
    func f(_ message: String, isPublic: Bool)
    func c(_ message: String, isPublic: Bool)
}

private struct LegacyLogger: LoggMessageProtocol {
    
    let logger: OSLog
    
    init(subsystem: String, category: String) {
        self.logger = OSLog(subsystem: subsystem, category: category)
    }
    
    func i(_ message: String, isPublic: Bool) {
        if isPublic {
            os_log(.info, log: logger, "%{public}", message)
        } else {
            os_log(.info, log: logger, "%{private}", message)
        }
    }
    
    func n(_ message: String, isPublic: Bool) {
        if isPublic {
            os_log(.info, log: logger, "%{public}", message)
        } else {
            os_log(.info, log: logger, "%{private}", message)
        }
    }
    
    func d(_ message: String, isPublic: Bool) {
        if isPublic {
            os_log(.debug, log: logger, "%{public}", message)
        } else {
            os_log(.debug, log: logger, "%{private}", message)
        }
    }
    
    func t(_ message: String, isPublic: Bool) {
        if isPublic {
            os_log(.default, log: logger, "%{public}", message)
        } else {
            os_log(.default, log: logger, "%{private}", message)
        }
    }
    
    func e(_ message: String, isPublic: Bool) {
        if isPublic {
            os_log(.error, log: logger, "%{public}", message)
        } else {
            os_log(.error, log: logger, "%{private}", message)
        }
    }
    
    func w(_ message: String, isPublic: Bool) {
        if isPublic {
            os_log(.error, log: logger, "%{public}", message)
        } else {
            os_log(.error, log: logger, "%{private}", message)
        }
    }
    
    func f(_ message: String, isPublic: Bool) {
        if isPublic {
            os_log(.fault, log: logger, "%{public}", message)
        } else {
            os_log(.fault, log: logger, "%{private}", message)
        }
    }
    
    func c(_ message: String, isPublic: Bool) {
        if isPublic {
            os_log(.fault, log: logger, "%{public}", message)
        } else {
            os_log(.fault, log: logger, "%{private}", message)
        }
    }
}

@available(iOS 14.0, *)
extension Logger: LoggMessageProtocol {
    func n(_ message: String, isPublic: Bool) {
        if isPublic {
            notice("\(message, privacy: .public)")
        } else {
            notice("\(message)")
        }
        
    }
    
    func d(_ message: String, isPublic: Bool) {
        if isPublic {
            debug("\(message, privacy: .public)")
        } else {
            debug("\(message)")
        }
        
    }
    
    func t(_ message: String, isPublic: Bool) {
        if isPublic {
            trace("\(message, privacy: .public)")
        } else {
            trace("\(message)")
        }
        
    }
    
    func i(_ message: String, isPublic: Bool) {
        if isPublic {
            info("\(message, privacy: .public)")
        } else {
            info("\(message)")
        }
        
    }
    
    func e(_ message: String, isPublic: Bool) {
        if isPublic {
            error("\(message, privacy: .public)")
        } else {
            error("\(message)")
        }
        
    }
    
    func w(_ message: String, isPublic: Bool) {
        if isPublic {
            warning("\(message, privacy: .public)")
        } else {
            warning("\(message)")
        }
        
    }
    
    func f(_ message: String, isPublic: Bool) {
        if isPublic {
            fault("\(message, privacy: .public)")
        } else {
            fault("\(message)")
        }
        
    }
    
    func c(_ message: String, isPublic: Bool) {
        if isPublic {
            critical("\(message, privacy: .public)")
        } else {
            critical("\(message)")
        }
        
    }
}

struct L {
    private let logger: LoggMessageProtocol
    
    init(subsystem: String, category: String) {
        if #available(iOS 14.0, *) {
            logger = Logger(subsystem: subsystem, category: category)
        } else {
            logger = LegacyLogger(subsystem: subsystem, category: category)
        }
    }
    
    func n(_ message: String, isPublic: Bool = false) {
        logger.n(message, isPublic: isPublic)
    }
    
    func d(_ message: String, isPublic: Bool = false) {
        logger.d(message, isPublic: isPublic)
    }
    
    func t(_ message: String, isPublic: Bool = false) {
        logger.t(message, isPublic: isPublic)
    }
    
    func i(_ message: String, isPublic: Bool = false) {
        logger.i(message, isPublic: isPublic)
    }
    
    func e(_ message: String, isPublic: Bool = false) {
        logger.e(message, isPublic: isPublic)
    }
    
    func w(_ message: String, isPublic: Bool = false) {
        logger.w(message, isPublic: isPublic)
    }
    
    func f(_ message: String, isPublic: Bool = false) {
        logger.f(message, isPublic: isPublic)
    }
    
    func c(_ message: String, isPublic: Bool = false) {
        logger.c(message, isPublic: isPublic)
    }
}
