//
//  AppIconView.swift
//  iOS-Common-Libraries
//
//  Created by Dinesh Harjani on 1/7/21.
//

import SwiftUI

// MARK: - AppIconView

struct AppIconView: View {
    
    private static let appCornerRadious = 4.0 as CGFloat
    
    var body: some View {
        #if os(OSX)
        Image(nsImage: NSApplication.shared.applicationIconImage)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .cornerRadius(AppIconView.appCornerRadious)
        #elseif os(iOS)
        Bundle.main.iconFileName
            .flatMap { UIImage(named: $0) }
            .map { Image(uiImage: $0) }
            .aspectRatio(contentMode: .fit)
            .cornerRadius(AppIconView.appCornerRadious)
        #endif
    }
}

// MARK: Icon

#if os(iOS)
fileprivate extension Bundle {
    
    var iconFileName: String? {
        guard let icons = infoDictionary?["CFBundleIcons"] as? [String: Any],
              let primaryIcon = icons["CFBundlePrimaryIcon"] as? [String: Any],
              let iconFiles = primaryIcon["CFBundleIconFiles"] as? [String],
              let iconFileName = iconFiles.last
        else { return nil }
        return iconFileName
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
