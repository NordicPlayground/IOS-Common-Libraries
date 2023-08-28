//
//  SwiftUIView.swift
//  
//
//  Created by Nick Kibysh on 10/07/2023.
//

import SwiftUI

@available(macOS 13.0, *)
@available(iOS 16.0, *)
public struct RSSIView: View {
    
    public let rssi: SignalQualytiConvertable
    
    public init(rssi: SignalQualytiConvertable) {
        self.rssi = rssi
    }
    
    public var body: some View {
        VStack {
            Image(systemName: "cellularbars", variableValue: variableValue)
                .foregroundColor(color)
        }
    }
    
    private var variableValue: Double {
        switch rssi.signalQuality {
        case .outOfRange: return 0
        case .practicalWorst: return 1.0 / 4.0
        case .bad: return 2.0 / 4.0
        case .ok: return 3.0 / 4.0
        case .good: return 1
        }
    }
    
    private var color: Color {
        switch rssi.signalQuality {
        case .outOfRange: return Color.secondary
        case .good: return Color.green
        case .ok: return Color.yellow
        case .bad: return Color.orange
        case .practicalWorst: return Color.red
        }
    }
}

@available(macOS 13.0, *)
@available(iOS 16.0, *)
struct RSSIView_Previews: PreviewProvider {
    static let v = [-60, -90, -100, -120, 10]
    
    static var previews: some View {
        List(v, id: \.self) { s in
            RSSIView(rssi: BluetoothRSSI(rawValue: s))
        }
    }
}
