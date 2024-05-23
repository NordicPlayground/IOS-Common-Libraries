//
//  PipelineManager.swift
//  nRF-Wi-Fi-Provisioner (iOS)
//
//  Created by Dinesh Harjani on 18/4/24.
//

import Foundation

// MARK: - PipelineManager

public class PipelineManager<Stage: PipelineStage>: ObservableObject {
    
    // MARK: Properties
    
    @Published public var stages: [Stage]
    @Published public var progress: Double
    @Published public var started: Bool
    @Published public var success: Bool {
        didSet {
            defer {
                delegate?.onProgressUpdate()
            }
            
            guard success else { return }
            for i in stages.indices {
                stages[i].complete()
            }
            progress = 100.0
        }
    }
    @Published public var error: Error?
    
    weak public var delegate: PipelineManagerDelegate?
    
    public var currentStage: Stage! {
        stages.first { $0.inProgress }
    }
    
    public var inProgress: Bool {
        currentStage != nil
    }
    
    public var finishedWithError: Bool {
        !success && error != nil
    }
    
    public var isIndeterminate: Bool {
        currentStage?.isIndeterminate ?? true
    }
    
    // MARK: Init
    
    public init(initialStages stages: [Stage]) {
        self.stages = stages
        self.progress = 0.0
        self.started = false
        self.success = false
        for i in self.stages.indices {
            self.stages[i].update(inProgress: false)
        }
    }
}

// MARK: - Delegate

public protocol PipelineManagerDelegate: AnyObject {
    
    func onProgressUpdate()
}

// MARK: - Public API

public extension PipelineManager {
    
    func stagesBefore(_ stage: Stage) -> Array<Stage>.SubSequence {
        return stages.prefix(while: { $0 != stage })
    }
    
    func stagesFrom(_ stage: Stage) -> Array<Stage>.SubSequence {
        guard let limitIndex = stages.firstIndex(where: \.id, equals: stage.id) else {
            return []
        }
        return stages.suffix(from: limitIndex)
    }
    
    func isCompleted(_ stage: Stage) -> Bool {
        guard let index = stages.firstIndex(where: \.id, equals: stage.id) else { return false }
        return stages[index].completed
    }
    
    func inProgress(_ stage: Stage, progress: Float? = nil) {
        guard let index = stages.firstIndex(where: \.id, equals: stage.id) else { return }
        started = true
        if let progress {
            stages[index].progress = progress
        }
        stages[index].update(inProgress: true)
        
        for previousIndex in stages.indices where previousIndex < index {
            stages[previousIndex].complete()
        }
        delegate?.onProgressUpdate()
    }
    
    func completed(_ stage: Stage) {
        guard let index = stages.firstIndex(where: \.id, equals: stage.id) else { return }
        stages[index].complete()
        delegate?.onProgressUpdate()
    }
    
    func onError(_ error: Error) {
        guard let currentStage = stages.firstTrueIndex(for: \.inProgress) else { return }
        stages[currentStage].declareError()
        self.error = error
        delegate?.onProgressUpdate()
    }
}
