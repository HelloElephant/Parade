//
//  UIColor+Hex.swift
//  Xcode Flight
//
//  Copyright © 2017 Anton Doudarev. All rights reserved.

import Foundation
import UIKit

var colorCache = [Int : UIColor]()

extension UIColor {
    
    static public func color(forHex hex: Int, withAlpha alpha : CGFloat = 1.0) -> UIColor {
        if let color = colorCache[hex] {
            return color
        }
        
        colorCache[hex] = UIColor(hex : hex, withAlpha : alpha)
        
        return colorCache[hex]!
    }
    
    convenience init(hex: Int, withAlpha alpha : CGFloat = 1.0) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        
        self.init(red: components.R, green: components.G, blue: components.B, alpha: alpha)
    }
 
}
