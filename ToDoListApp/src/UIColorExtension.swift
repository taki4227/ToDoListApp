//
//  UIColorExtension.swift
//  ToDoListApp
//
//  Created by Naoki Takimoto on 2017/03/17.
//  Copyright © 2017年 takimoto. All rights reserved.
//

import UIKit

extension UIColor {


    /// アプリのテーマカラー
    struct AppColor {
        /// 暗めのテーマカラー #colorLiteral(red: 0.4274509804, green: 0.7568627451, blue: 0.6196078431, alpha: 1)
        static var darkPrimaryColor: UIColor { return UIColor.hex(hexStr: "#689F38", alpha: 1) }
        /// デフォルトテーマカラー #colorLiteral(red: 0.5450980392, green: 0.7647058824, blue: 0.2901960784, alpha: 1)
        static var defaultPrimaryColor: UIColor { return UIColor.hex(hexStr: "#8BC34A", alpha: 1) }
        /// 明るいのテーマカラー #colorLiteral(red: 0.862745098, green: 0.9294117647, blue: 0.7843137255, alpha: 1)
        static var lightPrimaryColor: UIColor { return UIColor.hex(hexStr: "#DCEDC8", alpha: 1) }
        /// アクセントカラー #colorLiteral(red: 0, green: 0.5882352941, blue: 0.5333333333, alpha: 1)
        static var accentColor: UIColor { return UIColor.hex(hexStr: "#009688", alpha: 1) }
        /// テキストカラー #colorLiteral(red: 0.1294117647, green: 0.1294117647, blue: 0.1294117647, alpha: 1)
        static var primaryTextColor: UIColor { return UIColor.hex(hexStr: "#212121", alpha: 1) }
        /// セカンドテキストカラー #colorLiteral(red: 0.4588235294, green: 0.4588235294, blue: 0.4588235294, alpha: 1)
        static var secondaryTextColor: UIColor { return UIColor.hex(hexStr: "#757575", alpha: 1) }
        /// 境界線カラー #colorLiteral(red: 0.7411764706, green: 0.7411764706, blue: 0.7411764706, alpha: 1)
        static var dividerColor: UIColor { return UIColor.hex(hexStr: "#BDBDBD", alpha: 1) }

        /// ハイライトカラー #colorLiteral(red: 1, green: 0.8039215686, blue: 0.8235294118, alpha: 1)
        static var highlightColor: UIColor { return UIColor.hex(hexStr: "#FFCDD2", alpha: 1) }
        /// DeleteボタンのBGカラー #colorLiteral(red: 0.9960784314, green: 0.2196078431, blue: 0.1411764706, alpha: 1)
        static var deleteButtonBgColor: UIColor { return UIColor.hex(hexStr: "#FE3824", alpha: 1) }
    }

    /// RGB値をUIColorに変換
    ///
    /// - Parameters:
    ///   - r: R値
    ///   - g: G値
    ///   - b: B値
    ///   - alpha: Alpha値
    /// - Returns: UIColor
    class func rgb(r: Int, g: Int, b: Int, alpha: CGFloat) -> UIColor {
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }


    /// Hex値をUIColorに変換
    ///
    /// - Parameters:
    ///   - hexStr: Hex値
    ///   - alpha: Alpha値
    /// - Returns: UIColor, 存在しない場合は白を返す
    class func hex ( hexStr: String, alpha: CGFloat) -> UIColor {
        var hexStr = hexStr
        hexStr = hexStr.replacingOccurrences(of: "#", with: "")

        if hexStr.characters.count == 3 {
            var newHexStr = ""
            for c in hexStr.characters {
                newHexStr += "\(c)\(c)"
            }
            hexStr = newHexStr
        }

        let scanner = Scanner(string: hexStr as String)
        var color: UInt32 = 0
        if scanner.scanHexInt32(&color) {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            return UIColor(red: r, green: g, blue: b, alpha: alpha)
        } else {
            print("invalid hex string")
            return UIColor.white
        }
    }
}
