//
//  ColorHelpers.swift
//  GuestPasses
//
//  Created by Nathan Fulkerson on 3/24/17.
//  Copyright © 2017 Nathan Fulkerson. All rights reserved.
//

import UIKit
// This extension comes from here: https://medium.com/ios-os-x-development/ios-extend-uicolor-with-custom-colors-93366ae148e6#.xx3zncsay
// Which I shared in the Slack. Gives a convenient way to quickly set colors on UI objects programmatically.
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
    struct CustomColor {
        // for poor souls like me who don't consistently use a particular spelling of gray.
        typealias Grey = Gray
        struct Purple {
            static let light = UIColor(netHex: 0x8A6DAA)
            static let dark = UIColor(netHex: 0x3F3648)
        }
        
        struct Gray {
            static let light = UIColor(netHex: 0xDBD6DF)
            static let steel = UIColor(netHex: 0xCBC6CF)
            static let dark = UIColor(netHex: 0x535253)
        }
        
        
    }
}

