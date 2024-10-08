//
//  FPSCounter.swift
//  nRF-Connect
//  iOSCommonLibraries
//
//  Created by Dinesh Harjani on 7/10/24.
//  Copyright © 2024 Nordic Semiconductor. All rights reserved.
//

import SwiftUI

// MARK: - FPSCounter

@available(iOS 16.0, macCatalyst 16.0, macOS 13.0, *)
public final class FPSCounter {
    
    private static let DotSize = CGSize(width: 8.0, height: 8.0)
    
    // MARK: Private Properties
    
    private let clock = ContinuousClock()
    
    private var currentSecondFrames: Int
    private var previousSecondFrames: Int
    private var previousSecond: Int
    
    private var previousSecondFrameTime: Float
    
    // MARK: Init
    
    public init() {
        self.currentSecondFrames = 0
        self.previousSecondFrames = 0
        self.previousSecond = -1
        self.previousSecondFrameTime = 0.0
    }
    
    // MARK: API
    
    public func countFrame(at instant: ContinuousClock.Instant.Duration) -> some View {
        let frameTime: Float = Float(instant.components.attoseconds) * 1e-12
        let second = Calendar.current.component(.second, from: .now)
        if second != previousSecond {
            previousSecond = second
            previousSecondFrames = currentSecondFrames
            currentSecondFrames = 1
            previousSecondFrameTime = frameTime
        } else {
            currentSecondFrames += 1
        }
        
        return HStack(alignment: .firstTextBaseline) {
            Circle()
                .fill(colorForFps(previousSecondFrames))
                .frame(width: Self.DotSize.width,
                       height: Self.DotSize.height)
            
            Text("\(previousSecondFrames) FPS")
            
            Text(String(format: "%.2f ms", previousSecondFrameTime))
                .foregroundStyle(colorForMs(previousSecondFrameTime))
                .font(.caption)
                .bold()
        }
    }
    
    // MARK: colorForFps
    
    func colorForFps(_ fps: Int) -> Color {
        switch fps {
        case 16...29:
            return .nordicSun
        case 30...58:
            return .nordicSky
        case 59...70:
            return .green
        case 71...240:
            return .nordicBlue
        default:
            return .nordicRed
        }
    }
    
    // MARK: colorForMs
    
    func colorForMs(_ ms: Float) -> Color {
        switch ms {
        case 0.0...8.34: // 120fps or faster
            return .purple
        case 8.34...16.66: // 120...60 fps
            return .nordicBlue
        case 16.67...33.33: // 60...30 fps
            return .green
        case 33.34...66.67: // 30...15 fps
            return .nordicSky
        default: // < 15 fps
            return .nordicRed
        }
    }
}
