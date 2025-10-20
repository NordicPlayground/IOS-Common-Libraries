//
//  FlickerModifier.swift
//  iOSCommonLibraries
//  nRF-Connect
//
//  Created by Dinesh Harjani on 12/3/25.
//  Created by Dinesh Harjani on 16/12/24.
//  Copyright © 2024 Nordic Semiconductor. All rights reserved.
//

import SwiftUI

// MARK: - FlickerView

@available(iOS 17.0, macCatalyst 17.0, macOS 14.0, *)
public struct FlickerView<Content: View>: View {
    
    // MARK: Private Properties
    
    @State private var start: Date = .now
    
    private let shaderLibrary = ShaderLibrary.bundle(.module)
//    let library = try device.makeLibrary(source: source options: nil)
//    let custom = FlickerShader.flickerShaderLibrary
    
//    private let shaderLibrary: ShaderLibrary! = FlickerShader.library
    private let animationInterval: Double = 1 / 24
    private let content: () -> Content
  
    // MARK: Init
    
    init(content: @escaping () -> Content) {
        self.content = content
    }
    
    // MARK: view
    
    public var body: some View {
        TimelineView(.animation(minimumInterval: animationInterval)) { timelineView in
            let timeSince = start.distance(to: timelineView.date)
            content()
                .visualEffect { content, proxy in
                    content
                        .colorEffect(shaderLibrary.flicker(
                            .float2(proxy.size),
                            .float(timeSince)
                        ))
                }
        }
    }
}

@available(iOS 17.0, macCatalyst 17.0, macOS 14.0, *)
fileprivate enum FlickerShader {
    
    static let library: ShaderLibrary? = {
        guard let mtlDevice = MTLCreateSystemDefaultDevice() else { return nil }
        
        let metalLibrary = try? mtlDevice.makeLibrary(source: Self.sourceCode, options: MTLCompileOptions())
        
        
        return nil
//        return ShaderLibrary(data: shaderAsData)
    }()
    
    private static let sourceCode = """

        #include <metal_stdlib>
        using namespace metal;

        // Source: https://www.reddit.com/r/godot/comments/mslgpu/flickering_neon_shader_for_a_comrade_better_with/?rdt=40964
        [[ stitchable ]] half4 flicker(float2 position, half4 color, float2 size, float time) {
            half brightness = 1.0;
            half brightnessDropPercent = 0.35;
            half glowPeriod = 1.202;
            half flickerPeriod = 30.391;
            half flickerSpikes = 30.81;
            
            half4 c = color;
            half flicker = sin(time * (flickerPeriod + sin(time) * flickerPeriod * 0.3));
            half graph = (sin(time * glowPeriod) * flickerSpikes - (flickerSpikes - 1.0));
            graph = half(graph > 0.0);
            
            half lowerEdge = 0.9;
            half upperEdge = 0.95;
            half cycle = smoothstep(lowerEdge, upperEdge, graph * flicker);
            
            c.rgb *= brightness - brightnessDropPercent * cycle;
            return c;
        }
    """
}

// MARK: - FlickerModifier

@available(iOS 17.0, macCatalyst 17.0, macOS 14.0, *)
public struct FlickerModifier: ViewModifier {
  
    public func body(content: Content) -> some View {
        FlickerView { content }
    }
}

// MARK: - View Extension

@available(iOS 17.0, macCatalyst 17.0, macOS 14.0, *)
public extension View {
      
    func flicker() -> some View {
        modifier(FlickerModifier())
    }
}
