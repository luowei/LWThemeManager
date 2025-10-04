//
//  LWThemeExtension.swift
//  LWThemeManager
//
//  Swift version of theme extensions
//  Copyright (c) 2015 luowei. All rights reserved.
//

import UIKit

extension UIColor {

    /// Creates a UIColor from an RGBA string
    /// - Parameter rgbaString: String in format "r,g,b" or "r,g,b,a" where values are 0-255
    /// - Returns: UIColor instance or nil if string is invalid
    static func theme_color(withRGBAString rgbaString: String) -> UIColor? {
        let components = rgbaString.components(separatedBy: ",")

        // Format: "r,g,b"
        if components.count == 3 {
            guard let red = Float(components[0]),
                  let green = Float(components[1]),
                  let blue = Float(components[2]) else {
                return nil
            }

            return UIColor(
                red: CGFloat(red / 255.0),
                green: CGFloat(green / 255.0),
                blue: CGFloat(blue / 255.0),
                alpha: 1.0
            )
        }

        // Format: "r,g,b,a"
        if components.count == 4 {
            guard let red = Float(components[0]),
                  let green = Float(components[1]),
                  let blue = Float(components[2]),
                  let alpha = Float(components[3]) else {
                return nil
            }

            return UIColor(
                red: CGFloat(red / 255.0),
                green: CGFloat(green / 255.0),
                blue: CGFloat(blue / 255.0),
                alpha: CGFloat(alpha / 255.0)
            )
        }

        return nil
    }

    /// Converts UIColor to RGBA string
    /// - Returns: String in format "r,g,b,a" where values are 0-255
    func theme_rgbaString() -> String? {
        // Special case for white color
        if self == UIColor.white {
            return "255,255,255,255"
        }

        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        guard getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return nil
        }

        let redDec = Int(red * 255)
        let greenDec = Int(green * 255)
        let blueDec = Int(blue * 255)
        let alphaDec = Int(alpha * 255)

        return "\(redDec),\(greenDec),\(blueDec),\(alphaDec)"
    }
}

extension CGColor {

    /// Creates a CGColor from an RGBA string
    /// - Parameter rgbaString: String in format "r,g,b" or "r,g,b,a" where values are 0-255
    /// - Returns: CGColor instance or nil if string is invalid
    static func theme_color(withRGBAString rgbaString: String) -> CGColor? {
        return UIColor.theme_color(withRGBAString: rgbaString)?.cgColor
    }

    /// Converts CGColor to RGBA string
    /// - Returns: String in format "r,g,b,a" where values are 0-255
    func theme_rgbaString() -> String? {
        return UIColor(cgColor: self).theme_rgbaString()
    }
}
