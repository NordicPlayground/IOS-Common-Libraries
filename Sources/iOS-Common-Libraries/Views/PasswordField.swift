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
    
    @Environment(\.colorScheme) var colorScheme
    
    // MARK: Private Properties
    
    private var password: Binding<String>
    private var enabled: Bool
    @State private var shouldRevealPassword = false
    
    // MARK: Init
    
    public init(_ binding: Binding<String>, enabled: Bool) {
        self.password = binding
        self.enabled = enabled
    }
    
    // MARK: Body
    
    public var body: some View {
        HStack {
            ZStack {
                if shouldRevealPassword {
                    TextField("Password", text: password)
                } else {
                    SecureField("Password", text: password)
                }
            }
            .disableAllAutocorrections()
            .textContentType(.password)
            .foregroundColor(.textFieldColor)
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
            PasswordField($emptyPassword, enabled: true)
            PasswordField($password, enabled: true)
            PasswordField($password, enabled: false)
        }
        .previewLayout(.sizeThatFits)
    }
}
#endif
