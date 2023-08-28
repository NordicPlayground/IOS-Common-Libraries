//
//  SwiftUIView.swift
//  
//
//  Created by Nick Kibysh on 02/05/2023.
//

import SwiftUI

@available(iOS 15.0, *)
// button style with nordicBlue color and rounded corners
public struct NordicPrimary: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled
    
    public init() { }
    
    public func makeBody(configuration: Configuration) -> some View {
        #if os(iOS)
        configuration.label
            .padding()
            .frame(maxWidth: .infinity)
            .background(isEnabled ? Color.nordicLake : .secondary)
            .foregroundColor(configuration.isPressed ? .init(white: 0.95) : .white)
            .cornerRadius(4)
            .shadow(radius: 2)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
        #else
        configuration.label.padding()
        #endif
    }
}

@available(iOS 15.0, *)
// button style with nordicBlue color and rounded corners
public struct NordicSecondary: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled
    
    public init() { }
    
    public func makeBody(configuration: Configuration) -> some View {
        #if os(iOS)
        configuration.label
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundColor(isEnabled ? Color.nordicLake : .secondary)
            .overlay(RoundedRectangle(cornerRadius: 4)
                .stroke(isEnabled ? Color.nordicLake : .secondary, lineWidth: 2)
            )
            .shadow(radius: 0.2)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
        #else
        configuration.label.padding()
        #endif
    }
}

@available(iOS 15.0, *)
// button style with nordicBlue color and rounded corners
public struct NordicPrimaryDistructive: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled
    
    public init() { }
    
    public func makeBody(configuration: Configuration) -> some View {
        #if os(iOS)
        configuration.label
            .padding()
            .frame(maxWidth: .infinity)
            .background(isEnabled ? .red : .secondary)
            .foregroundColor(configuration.isPressed ? .init(white: 0.95) : .white)
            .cornerRadius(4)
            .shadow(radius: 2)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
        #else
        configuration.label.padding()
        #endif
    }
}

@available(iOS 15.0, *)
// button style with nordicBlue color and rounded corners
public struct NordicSecondaryDistructive: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled
    
    public init() { }
    
    public func makeBody(configuration: Configuration) -> some View {
        #if os(iOS)
        configuration.label
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundColor(isEnabled ? .red : .secondary)
            .overlay(RoundedRectangle(cornerRadius: 4)
                .stroke(isEnabled ? .red : .secondary, lineWidth: 2)
            )
            .shadow(radius: 0.2)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            
        #else
        configuration.label.padding()
        #endif
    }
}


//struct SwiftUIView: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15.0, *) {
            VStack {
                Button("Primary Button Style") { }
                    .buttonStyle(NordicPrimary())
                Button("Secondary Button Style") { }
                    .buttonStyle(NordicSecondary())
                Button("Destructive Button Style") { }
                    .buttonStyle(NordicPrimaryDistructive())
                Button("Secondary Destructive Button Style") { }
                    .buttonStyle(NordicSecondaryDistructive())
                Button("Primary Button Style") { }
                    .disabled(true)
                    .buttonStyle(NordicPrimary())
                Button("Secondary Button Style") { }
                    .disabled(true)
                    .buttonStyle(NordicSecondary())
                Button("Destructive Button Style") { }
                    .disabled(true)
                    .buttonStyle(NordicPrimaryDistructive())
                Button("Secondary Destructive Button Style") { }
                    .disabled(true)
                    .buttonStyle(NordicSecondaryDistructive())
            }
            .padding()
            
        } else {
            Text("Button Style is not supported on older iOS versions")
        }
    }
}
