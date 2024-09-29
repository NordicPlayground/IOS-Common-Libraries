//
//  SwiftUIView.swift
//  
//
//  Created by Nick Kibysh on 07/07/2023.
//

import SwiftUI

@available(iOS 16.0, macOS 13.0, *)
public struct ContentUnavailableView<Action: View>: View {
    public let configuration: ContentUnavailableConfiguration
    let actions: (() -> Action)
    
    public init(configuration: ContentUnavailableConfiguration, actions: @escaping () -> Action = { EmptyView() }) {
        self.configuration = configuration
        self.actions = actions
    }
    
    public var body: some View {
        VStack(alignment: .center) {
            configuration.image?
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: configuration.imageWidth, height:
                        configuration.imageHeight)
                .foregroundColor(configuration.imageForegroundColor)
            
            configuration.text.map {
                Text($0)
                    .multilineTextAlignment(.center)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.secondary)
                    .padding()
            }
            
            configuration.secondaryText.map {
                Text($0)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
            }
            
            actions()
                .frame(maxWidth: 300)
        }
        .padding()
    }
}

@available(iOS 16, macOS 13, *)
struct ContentUnavailableView_Previews: PreviewProvider {
    static var previews: some View {
        ContentUnavailableView(
            configuration:
                ContentUnavailableConfiguration(
                    text: "No Devices",
                    secondaryText: "Start Scon",
                    systemName: "binoculars"
                )) {
                    Button("Action") {
                        
                    }
                    .buttonStyle(NordicPrimary())
                }
    }
}
