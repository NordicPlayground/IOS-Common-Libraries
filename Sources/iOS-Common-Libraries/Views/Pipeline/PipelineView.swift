//
//  PipelineView.swift
//  iOS-Common-Libraries
//
//  Created by Dinesh Harjani on 22/5/24.
//

import SwiftUI

// MARK: - PipelineView

public struct PipelineView<Stage: PipelineStage>: View {
    
    private let stage: Stage
    private let logLine: String
    private let accessoryLine: String?
    
    // MARK: Init
    
    public init(stage: Stage, logLine: String, accessoryLine: String? = nil) {
        self.stage = stage
        self.logLine = logLine
        self.accessoryLine = accessoryLine
    }
    
    // MARK: View
    
    public var body: some View {
        HStack {
            Image(systemName: stage.symbolName)
                .foregroundColor(stage.color)
                .frame(width: 20, height: 20)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(stage.status)
                    .foregroundColor(stage.color)

                if stage.inProgress || stage.encounteredAnError {
                    Text(logLine)
                        .font(.caption)
#if os(macOS)
                        .padding(.top, 1)
#endif
                }
                
                if stage.inProgress {
                    if let accessoryLine {
                        Text(accessoryLine)
                            .font(.caption2)
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                    }
                    
                    if stage.isIndeterminate {
                        IndeterminateProgressView()
                            .padding(.top, 2)
                            .padding(.trailing)
                    } else {
                        ProgressView(value: stage.progress, total: stage.totalProgress)
                            .progressViewStyle(.linear)
                            .padding(.top, 2)
                            .padding(.trailing)
                    }
                }
            }
            .padding(.leading, 6)
        }
    }
}
