//
//  View.swift
//  iOS-Common-Libraries
//
//  Created by Dinesh Harjani on 9/8/22.
//

import SwiftUI

// MARK: - FormIniOSListInMacOS

#if os(iOS)
typealias FormIniOSListInMacOS = Form
#elseif os(macOS)
typealias FormIniOSListInMacOS = List
#endif

// MARK: - View

extension View {
    
    @inlinable public func frame(size: CGSize, alignment: Alignment = .center) -> some View {
        return frame(width: size.width, height: size.height, alignment: alignment)
    }
    
    @inlinable public func centerTextInsideForm() -> some View {
        // Hack.
        return frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
    }
    
    @inlinable public func withoutListRowInsets() -> some View {
        return listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
    
    // MARK: - NavBar
    
    func setTitle(_ title: String) -> some View {
        #if os(iOS)
        return navigationBarTitle(title, displayMode: .inline)
        #else
        return navigationTitle(title)
        #endif
    }
    
    // MARK: - NavigationView
    
    @ViewBuilder
    func wrapInNavigationViewForiOS() -> some View {
        #if os(iOS)
        NavigationView {
            self
        }
        .setupNavBarBackground()
        .setSingleColumnNavigationViewStyle()
        .accentColor(.white)
        #else
        self
        #endif
    }
    
    // MARK: - UITextField
    
    func disableAllAutocorrections() -> some View {
        disableAutocorrection(true)
        #if os(iOS)
            .autocapitalization(.none)
        #endif
    }
}

// MARK: - Picker

extension Picker {
    
    @ViewBuilder
    func setAsComboBoxStyle() -> some View {
        self
        #if os(iOS)
            .pickerStyle(MenuPickerStyle())
            .accentColor(.primary)
        #endif
    }
    
    func setAsSegmentedControlStyle() -> some View {
        self
        #if os(iOS)
            .pickerStyle(SegmentedPickerStyle())
        #endif
    }
}

// MARK: - NavigationView

extension NavigationView {
    
    func setSingleColumnNavigationViewStyle() -> some View {
        self
        #if os(iOS)
            .navigationViewStyle(StackNavigationViewStyle())
        #endif
    }
    
     func setupNavBarBackground() -> NavigationView {
         #if os(iOS)
         let appearance = UINavigationBarAppearance()
         let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
         ]
         appearance.titleTextAttributes = attributes
         appearance.largeTitleTextAttributes = attributes
         appearance.backgroundColor = Assets.navBarBackground.uiColor // Dynamic Color.
         UINavigationBar.appearance().compactAppearance = appearance
         UINavigationBar.appearance().standardAppearance = appearance
         UINavigationBar.appearance().scrollEdgeAppearance = appearance
         #endif
         return self
    }
}
