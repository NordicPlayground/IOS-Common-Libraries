//
//  UIColor.swift
//  iOS-Common-Libraries
//
//  Created by Dinesh Harjani on 25/8/22.
//

#if os(iOS)
import UIKit

extension UIColor {
    
    public convenience init(rgba: RGBA) {
        self.init(red: rgba.red, green: rgba.green, blue: rgba.blue, alpha: rgba.alpha)
    }
    
    public convenience init(light: RGBA, dark: RGBA) {
        self.init { collection in
            collection.userInterfaceStyle == .dark
                ? UIColor(rgba: dark)
                : UIColor(rgba: light)
        }
    }
}
#endif
