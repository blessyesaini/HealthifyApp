//
//  UIFont+Extension.swift
//  Healthify
//
//  Created by Blessy Elizabeth Saini on 26/03/2022.
//

import UIKit
struct CustomFont {
    
    /*
     Example usage
     let system12 = CustomFont(.system, size: .standard(.h5)).instance
     let robotoMedium20 = CustomFont(.installed(.Medium), size: .standard(.h1)).instance
     let helveticaLight13 = CustomFont(.custom("Helvetica-Light"), size: .custom(13.0)).instance
     */
    
    
    enum FontName: String {
        case regular
        case bold
        var localizedFontName: String {
 
            switch self {
            case .regular:
                let regular = InterFontName.Regular.rawValue
                return  regular
            case .bold:
                let bold = InterFontName.Bold.rawValue
                return  bold
           
            }
            
        }

    }
    enum FontStyle: String {
        case regular
        case bold
        static func build(rawValue: String) -> FontStyle {
            return FontStyle(rawValue: rawValue) ?? .regular
        }
    }
    enum StandardSize: Double {
        case h1 = 32.0
        case h2 = 18.0
        case h3 = 24.0
        case h4 = 16.0
        case h5 = 13.0

    }
    
    enum FontType {
        case installed(FontName)
        case custom(String)
        case system
    }

    enum FontSize {
        case standard(StandardSize)
        case custom(Double)
        var value: Double {
            switch self {
            case let .standard(size):
                return size.rawValue
            case let .custom(customSize):
                return customSize
            }
        }
    }
    
    var type: FontType
    var size: FontSize

    init(_ type: FontType, size: FontSize) {
        self.type = type
        self.size = size
    }
    static func fontForStyleCode(_ code: FontStyle, customStyle: String?, fontSize: CGFloat?) -> UIFont {
       
        let size = CustomFont.FontSize.custom(Double(CGFloat(fontSize ?? 13.0)))
        switch code {
        case .regular:
            return CustomFont(.installed(.regular), size: size).instance
        case .bold:
            return CustomFont(.installed(.bold), size: size).instance
        }
    }
}

extension CustomFont
    {
        var instance: UIFont {
            var instanceFont: UIFont!
            switch type {
            case let .custom(fontName):
                guard let font = UIFont(name: fontName, size: CGFloat(size.value)) else {
                    fatalError("\(fontName) font is not installed, make sure it added in Info.plist and logged with Utility.logAllAvailableFonts()")
                }
                instanceFont = font
            case let .installed(fontName):
                guard let font = UIFont(name: fontName.localizedFontName, size: CGFloat(size.value)) else {
                    fatalError("\(fontName.localizedFontName) font is not installed, make sure it added in Info.plist and logged with Utility.logAllAvailableFonts()")
                }
                instanceFont = font
            case .system:
                instanceFont = UIFont.systemFont(ofSize: CGFloat(size.value))
           
            }
            return instanceFont
        }
    }

class Utility {
    
   /// Logs all available fonts from iOS SDK and installed custom font
   class func logAllAvailableFonts() {
      for family in UIFont.familyNames {
      print("\(family)")
      for name in UIFont.fontNames(forFamilyName: family) {
          print("   \(name)")
      }
       }
   }
}


enum InterFontName: String {
    case Regular  = "SFProDisplay-Regular"
    case Bold = "SFProDisplay-Bold"
 
}








