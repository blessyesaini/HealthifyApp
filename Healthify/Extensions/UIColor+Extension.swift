//
//  UIColor+Extension.swift
//  Healthify
//
//  Created by Blessy Elizabeth Saini on 26/03/2022.
//

import Foundation
import UIKit

enum CustomColor {
    case primary
    case secondary
    case greenLight
    case blueRegular
    
    var value: UIColor {
        var instanceColor = UIColor.clear
        switch self {
        case .primary:
            instanceColor = UIColor.init(hex: "#FFFFFF")
        case .secondary:
            instanceColor = UIColor.init(hex: "#FFFFFF", a: 0.5).withAlphaComponent(0.5)
        case .greenLight:
            instanceColor = UIColor.init(hex: "#84C7A6")
        case .blueRegular:
            instanceColor = UIColor.init(hex: "#0094FF")
        }
        return instanceColor
    }
    
    enum ColorCode: String {
        case primary
        case secondary
        case greenLight
        case blueRegular
        static func build(rawValue: String) -> ColorCode {
            return ColorCode(rawValue: rawValue) ?? .primary
        }
    }
    

    static func colorForCode(_ code: ColorCode, customColor: UIColor?) -> UIColor {
        switch code {

        case .primary:
            return CustomColor.primary.value
        case .secondary:
            return CustomColor.secondary.value
       
        case .greenLight:
            return CustomColor.greenLight.value
            
        case .blueRegular:
            return CustomColor.blueRegular.value
        }
        
        
    }
        
    
}

extension UIColor {
    /**
     Creates an UIColor from HEX String in "#363636" format

     - parameter hexString: HEX String in "#363636" format

     - returns: UIColor from HexString
     */
    convenience init(hexString: String) {
        var hexString: String = (hexString as NSString).trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString as String)

        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
        var color: UInt64 = 0
        scanner.scanHexInt64(&color)

        let mask = 0x0000_00FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask

        let red = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue = CGFloat(b) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
    
    public convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) {
      self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }

}

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: a)
    }
    
    convenience init(rgb: Int, a: CGFloat = 1.0) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF,
            a: a
        )
    }
    
    convenience init(hex: String,a: CGFloat = 1.0) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            self.init(rgb:0xcccccc, a: a)
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        self.init(rgb: Int(rgbValue))
    }
    
    static let sectionHeaderText: UIColor = UIColor(rgb: 0x50B1DE)
}


