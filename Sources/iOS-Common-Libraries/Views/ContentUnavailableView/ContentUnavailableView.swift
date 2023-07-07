//
//  SwiftUIView.swift
//  
//
//  Created by Nick Kibysh on 07/07/2023.
//

import SwiftUI

@available(iOS 15.0, *)
struct ContentUnavailableView: View {
    let configuration: ContentUnavailableConfiguration
    
    var body: some View {
        VStack {
            configuration.image?
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: configuration.imageWidth, height:
                        configuration.imageHeight)
                .foregroundColor(configuration.imageForegroundColor)
            
            configuration.text.map {
                Text($0).font(.title)
            }
            
            configuration.secondaryText.map {
                Text($0).foregroundColor(.secondary)
            }
            
            configuration.buttonConfiguration.map { config in
                Button(config.title, action: config.action)
                    // TODO: Use `buttonStyle` from `config`
                    .buttonStyle(NordicPrimary())
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
