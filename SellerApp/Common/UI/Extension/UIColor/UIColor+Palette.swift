//
//  UIColor+Palette.swift
//  SellerApp
//
//  Created by Berdil Ilyada Karacam on 19.11.2021.
//

import UIKit

extension UIColor {
    
    static var csDarkBlack: UIColor {
        return UIColor(r: 85, g: 105, b: 142)
    }
    
    static var csDarkGray: UIColor {
        return UIColor(r: 112, g: 125, b: 152)
    }
    
    static var csLightGray: UIColor {
        return UIColor(r: 233, g: 236, b: 245)
    }
    
    static var csLightBackground: UIColor {
        return UIColor(r: 250, g: 251, b: 255)
    }
    
    static var csDarkGreen: UIColor {
        return UIColor(r: 81, g: 181, b: 73)
    }
    
    static var csLightGreen: UIColor {
        return UIColor(r: 226, g: 247, b: 225)
    }
    
    static var csPlaceholderColor: UIColor {
        return UIColor(r: 166, g: 175, b: 196)
    }
    
    static var csShadowColor: UIColor {
        return UIColor(r: 190, g: 190, b: 190, alpha: 0.16)
    }
}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: alpha)
    }
}
