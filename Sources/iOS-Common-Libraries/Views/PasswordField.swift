//
//  PasswordField.swift
//  nRF-Edge-Impulse
//  iOS-Common-Libraries
//
//  Created by Dinesh Harjani on 8/4/21.
//

import SwiftUI

// MARK: - PasswordField

public struct PasswordField: View {
    
    // MARK: Private Properties
    
    private let title: String
    private var password: Binding<String>
    private var enabled: Bool
    @State private var shouldRevealPassword = false
    
    // MARK: Init
    
    public init(_ title: String = "Type Password Here", binding: Binding<String>, enabled: Bool) {
        self.title = title
        self.password = binding
        self.enabled = enabled
    }
    
    // MARK: Body
    
    public var body: some View {
        HStack {
            ZStack {
                if shouldRevealPassword {
                    TextField(title, text: password)
                } else {
                    SecureField(title, text: password)
                }
            }
            .disableAllAutocorrections()
            .textContentType(.password)
            .disabled(!enabled)
            
            Button(action: {
                shouldRevealPassword.toggle()
            }) {
                Image(systemName: shouldRevealPassword ? "eye.slash" : "eye")
                    .accentColor(.nordicDarkGrey)
            }
        }
    }
}

// MARK: - Preview

#if DEBUG
struct PasswordField_Previews: PreviewProvider {
    
    @State static var emptyPassword: String = ""
    @State static var password: String = "#LookWhatYouMadeMeDo"
    
    static var previews: some View {
        Group {
            PasswordField(binding: $emptyPassword, enabled: true)
            PasswordField(binding: $password, enabled: true)
            PasswordField(binding: $password, enabled: false)
        }
        .previewLayout(.sizeThatFits)
    }
}
#endif
