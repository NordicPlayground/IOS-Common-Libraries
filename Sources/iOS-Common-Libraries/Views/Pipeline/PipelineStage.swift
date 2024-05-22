//
//  PipelineStage.swift
//  nRF-Wi-Fi-Provisioner (iOS)
//  iOS-Common-Libraries
//
//  Created by Dinesh Harjani on 17/4/24.
//

import Foundation
import SwiftUI

// MARK: - PipelineStage

public protocol PipelineStage: Identifiable, Hashable, CaseIterable {
    
    var symbolName: String { get }
    var todoStatus: String { get }
    var inProgressStatus: String { get }
    var completedStatus: String { get }
    var progress: Float { get }
    var totalProgress: Float { get }
    var isIndeterminate: Bool { get }
    var completed: Bool { get set }
    var inProgress: Bool { get set }
    var encounteredAnError: Bool { get set }
}

public extension PipelineStage {
    
    var id: String { todoStatus }
    
    var status: String {
        guard !completed else { return completedStatus }
        return inProgress || encounteredAnError ? inProgressStatus : todoStatus
    }
    
    var color: Color {
        if completed {
            return .succcessfulActionButtonColor
        } else if encounteredAnError {
            return .nordicRed
        } else if inProgress {
            return .nordicSun
        }
        return .disabledTextColor
    }
    
    var isIndeterminate: Bool {
        totalProgress <= .leastNonzeroMagnitude
    }
    
    mutating func update(inProgress: Bool = false, isCompleted: Bool = false) {
        self.encounteredAnError = false
        self.inProgress = inProgress
        self.completed = isCompleted
    }
    
    mutating func declareError() {
        guard inProgress else { return }
        inProgress = false
        encounteredAnError = true
    }
}
