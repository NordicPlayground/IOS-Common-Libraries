//
//  AppIconView.swift
//  iOS-Common-Libraries
//
//  Created by Dinesh Harjani on 1/7/21.
//

import SwiftUI

// MARK: - AppIconView

public struct AppIconView: View {
    
    private static let appCornerRadious = 4.0 as CGFloat
    
    // MARK: Init
    
    public init() {}
    
    // MARK: View
    
    public var body: some View {
        #if os(OSX)
        Image(nsImage: NSApplication.shared.applicationIconImage)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .cornerRadius(AppIconView.appCornerRadious)
        #elseif os(iOS) || targetEnvironment(macCatalyst)
        Bundle.main.iconFileName
            .flatMap { UIImage(named: $0) }
            .map {
                Image(uiImage: $0)
                    .resizable()
            }
            .aspectRatio(contentMode: .fit)
            .cornerRadius(AppIconView.appCornerRadious)
        #endif
    }
}

// MARK: Icon

#if os(iOS) || targetEnvironment(macCatalyst)
internal extension Bundle {
    
    var iconFileName: String? {
        if let icons = infoDictionary?["CFBundleIcons"] as? [String: Any],
           let primaryIcon = icons["CFBundlePrimaryIcon"] as? [String: Any],
           let iconFiles = primaryIcon["CFBundleIconFiles"] as? [String],
           let iconFileName = iconFiles.last {
            return iconFileName
        } else if let bundleAppIcon = infoDictionary?["CFBundleIconFile"] as? String {
            return bundleAppIcon
        }
        return nil
    }
}
#endif

// MARK: - Preview

struct AppIconView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AppIconView()
                .frame(width: 80, height: 80)
        }
        .previewLayout(.sizeThatFits)
    }
}
