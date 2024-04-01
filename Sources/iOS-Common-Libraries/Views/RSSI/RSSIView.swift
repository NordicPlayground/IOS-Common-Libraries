//
//  RSSIView.swift.swift
//  iOS-Common-Libraries
//
//  Created by Nick Kibysh on 15/07/2022.
//  Created by Dinesh Harjani on 1/4/24.
//

import SwiftUI

// MARK: - RSSIView

public struct RSSIView: View {
    let rssi: RSSI
    
    public init(rssi: RSSI) {
        self.rssi = rssi
    }
    
    public var body: some View {
        RSSIShape(
            filledBarCount: rssi.numberOfBars, totalBarCount: 4
        )
        .fill(rssi.color)
    }
}

// MARK: - Preview

#if DEBUG
struct RSSIView_Previews: PreviewProvider {
    
    static var previews: some View {
        RSSIView(rssi: .good)
            .padding()
    }
}
#endif
