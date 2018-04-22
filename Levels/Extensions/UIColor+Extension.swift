//
//  UIColor+Extension.swift
//  Levels
//
//  Created by Emanuel  Guerrero on 4/22/18.
//  Copyright © 2018 The SilverLogic. All rights reserved.
//

import UIKit

// MARK: - Private Class Attributes For Hex Values
private extension UIColor {
    @nonobjc static var lightTealHexValue: UInt = 0x29AAE1
    @nonobjc static var darkTealHexValue: UInt = 0x1B75BC
    @nonobjc static var lightBlueHexValue: UInt = 0xC3DDEE
    @nonobjc static var questionMarkRedHexValue: UInt = 0xED1C24
}


// MARK: - Private Class Methods
private extension UIColor {
    static func colorFromHexValue(_ hexValue: UInt, alpha: CGFloat = 1.0) -> UIColor {
        let redValue = CGFloat(((Float)((hexValue & 0xFF0000) >> 16)) / 255.0)
        let greenValue = CGFloat(((Float)((hexValue & 0xFF00) >> 8)) / 255.0)
        let blueValue = CGFloat(((Float)(hexValue & 0xFF)) / 255.0)
        return UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: alpha)
    }
}


// MARK: - Application Colors
extension UIColor {
    static var lightTeal: UIColor { return colorFromHexValue(lightTealHexValue) }
    static var darkTeal: UIColor { return colorFromHexValue(darkTealHexValue) }
    static var lightBlue: UIColor { return colorFromHexValue(lightBlueHexValue) }
    static var questionMarkRed: UIColor { return colorFromHexValue(questionMarkRedHexValue) }
}
