//
//  SwiftUIView.swift
//  
//
//  Created by Nick Kibysh on 07/07/2023.
//

import SwiftUI

@available(iOS 15.0, *)
public struct ContentUnavailableView: View {
    public let configuration: ContentUnavailableConfiguration
    
    public init(configuration: ContentUnavailableConfiguration) {
        self.configuration = configuration
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
                    .font(.title)
            }
            
            configuration.secondaryText.map {
                Text($0)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    
            }
            
            configuration.buttonConfiguration.map { config in
                Button(config.title, action: config.action)
                    // TODO: Use `buttonStyle` from `config`
                    .buttonStyle(NordicPrimary())
                    .frame(maxWidth: 250)
            }
        }
    }
}

@available(iOS 15.0, *)
struct ContentUnavailableView_Previews: PreviewProvider {
    static var previews: some View {
        ContentUnavailableView(
            configuration:
                ContentUnavailableConfiguration(
                    text: "No Devices",
                    secondaryText: "Start Scon",
                    systemName: "binoculars",
                    buttonConfiguration: ContentUnavailableConfiguration.ButtonConfiguration(
                        title: "Button",
                        style: NordicSecondary(),
                        action: {
                        
                    })
                )
        )
    }
}
