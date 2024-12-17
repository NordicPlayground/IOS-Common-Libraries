//
//  SwiftUIView.swift
//  iOSCommonLibraries
//
//  Created by Dinesh Harjani on 17/12/24.
//  Copyright © 2024 Nordic Semiconductor. All rights reserved.
//

import SwiftUI

public extension ProgressView {

    func fixedCircularProgressView() -> some View {
        self
            .progressViewStyle(.circular)
            .id(UUID())
    }
}
