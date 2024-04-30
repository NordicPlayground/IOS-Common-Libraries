//
//  View.swift
//  iOS-Common-Libraries
//
//  Created by Dinesh Harjani on 13/7/22.
//  Copyright © 2022 Nordic Semiconductor. All rights reserved.
//

import SwiftUI

// MARK: - doOnce()

public extension View {
    
    func doOnce(_ action: @escaping () -> Void) -> some View {
        modifier(OnceOnly(action: action))
    }
}

private struct OnceOnly: ViewModifier {
    
    let action: () -> Void
    
    @State private var doneAlready = false
    
    func body(content: Content) -> some View {
        // And then, track it here
        content.onAppear {
            guard !doneAlready else { return }
            doneAlready = true
            action()
        }
    }
}
