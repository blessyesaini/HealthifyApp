//
//  BaseLabel.swift
//  Healthify
//
//  Created by Blessy Elizabeth Saini on 26/03/2022.
//


import UIKit

class BaseLabel: UILabel {

    
    
    @IBInspectable var textColorCode: String = CustomColor.ColorCode.primary.rawValue {
        didSet {
            setTextColorFromCode()
        }
    }

    @IBInspectable var textFontStyle: String = CustomFont.FontStyle.regular.rawValue {
        didSet {
            setFontStyle()
        }
    }

    @IBInspectable var fontSize: CGFloat = 14.0 {
        didSet {
            setFontStyle()
        }
    }

    func setTextColorFromCode() {
        let code = CustomColor.ColorCode.build(rawValue: textColorCode)
        textColor = CustomColor.colorForCode(code, customColor: textColor)
    }

    func setFontStyle() {
        let code = CustomFont.FontStyle.build(rawValue: textFontStyle)
        font = CustomFont.fontForStyleCode(code, customStyle: font.fontName, fontSize: fontSize)
    }
}

extension UILabel {

        var isTruncated: Bool {

            guard let labelText = text else {
                return false
            }
            let labelFont = self.font ?? CustomFont(.installed(.regular), size: .standard(.h1)).instance
            let labelTextSize = (labelText as NSString).boundingRect(
                with: CGSize(width: frame.size.width, height: .greatestFiniteMagnitude),
                options: .usesLineFragmentOrigin,
                attributes: [.font: labelFont],
                context: nil).size

            return labelTextSize.height > bounds.size.height
        }

}
