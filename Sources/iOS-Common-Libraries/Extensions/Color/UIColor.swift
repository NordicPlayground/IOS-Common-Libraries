//
//  UIColor.swift
//  iOS-Common-Libraries
//
//  Created by Dinesh Harjani on 25/8/22.
//

#if os(iOS) || targetEnvironment(macCatalyst)
import UIKit

// MARK: - RGB

public extension UIColor {
    
    convenience init(rgb: RGB) {
        self.init(red: CGFloat(rgb.red) / RGB.RGBMAXf,
                  green: CGFloat(rgb.green) / RGB.RGBMAXf,
                  blue: CGFloat(rgb.blue) / RGB.RGBMAXf,
                  alpha: 1.0)
    }
    
    var rgb: RGB {
        guard let components = cgColor.components else { return 0 }
        return RGB(red: components[0], green: components[1], blue: components[2])
    }
}

// MARK: - RGBA

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

// MARK: - Colors

extension UIColor {
    
    static let nordicLabel: UIColor = .label
    static let nordicDisabledLabel: UIColor = .secondaryLabel
}

#endif
