//
//  TextFieldAlertModifier.swift
//  iOS-Common-Libraries
//
//  Created by Dinesh Harjani on 19/8/24.
//

import SwiftUI

// MARK: - TextFieldAlertModifier

public struct TextFieldAlertModifier: ViewModifier {
    
    // MARK: Private Properties
    
    private let title: String
    private let message: String
    @Binding private var isPresented: Bool
    @Binding private var text: String
    private let onPositiveAction: () -> Void
    
    // MARK: Init
    
    public init(title: String, message: String,
         isPresented: Binding<Bool>, text: Binding<String>,
         onPositiveAction: @escaping () -> Void) {
        self.title = title
        self.message = message
        _isPresented = isPresented
        _text = text
        self.onPositiveAction = onPositiveAction
    }
    
    // MARK: body
    
    public func body(content: Content) -> some View {
        content
            .alert(title,
                   isPresented: $isPresented) {
                Button("Cancel", role: .cancel, action: {
                    $isPresented.wrappedValue = false
                })
                
                Button("OK", action: onPositiveAction)
        
                TextField("", text: $text)
                    .textContentType(.username)
            } message: {
                Text(message)
            }
    }
}

// MARK: View

public extension View {
    
    func textFieldAlert(title: String, message: String,
                        isPresented: Binding<Bool>, text: Binding<String>,
                        onPositiveAction: @escaping () -> Void) -> ModifiedContent<Self, TextFieldAlertModifier> {
        self.modifier(
            TextFieldAlertModifier(title: title, message: message, isPresented: isPresented, text: text, onPositiveAction: onPositiveAction)
        )
    }
}
