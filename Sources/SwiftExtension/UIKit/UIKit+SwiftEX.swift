//
//  UITableView+SwiftEX.swift
//  ssd
//
//  Created by PomCat on 2020/8/7.
//  PomCat
//

import Foundation
import UIKit

public extension IndexPath {

    // Helper Methods
    func incrementRow(plus: Int=1) -> IndexPath {
        return IndexPath(row: row + plus, section: section)
    }

    func incrementSection(plus: Int=1) -> IndexPath {
        return IndexPath(row: 0, section: section + plus)
    }

    func next(in table: UITableView) -> IndexPath? {
        // if can find cell for next row, return next row's IndexPath
        if let _ = table.cellForRow(at: incrementRow()) {
            return incrementRow()
        }
        // cannot find next row, try to find row 0 in next section
        else if let _ = table.cellForRow(at: incrementSection()) {
            return incrementSection()
        }

        // can find neither next row nor next section, the current indexPath is already the very last IndexPath in the given table
        return nil
    }
}

public extension UILabel {
    
    func JJQuickSetUI(style: String, lanFontType:UIFont.LanHuFont, color:UIColor) {
        let arraySubstrings: [Substring] = style.split(separator: "*")
        
        var size:CGFloat = 14.0
  
        for item in arraySubstrings {
            if let inSize = Int(item) {
                size = CGFloat(inSize)
            }
        }
        
        self.font = UIFont.lanhu_font(type: lanFontType, size: size)
        self.textColor = color
    }
    
    func JJQuickSetUI(style: String, fontType:UIFont.HRFontType, color:UIColor) {
        JJQuickSetUI(style: style, fontType:fontType)
        self.textColor = color
    }
    /// 快速定制样式
    /// - Parameters:
    ///   - style: "15*#FFFFFF*0.5"
    ///   - fontType: 字体枚举
    func JJQuickSetUI(style: String, fontType:UIFont.HRFontType) {
        let arraySubstrings: [Substring] = style.split(separator: "*")
        
        var size:CGFloat = 14.0
        var alpha:CGFloat = 1.0
        var colStr = "#FFFFFF"
        
        for item in arraySubstrings {
            if let inSize = Int(item) {
                size = CGFloat(inSize)
            } else if item.contains("#") {
                colStr = String(item)
            } else if let inAlpha = Double(item) {
                alpha = CGFloat(inAlpha)
            }
        }
        
        self.font = UIFont.JJ_font(type: fontType, size: size)
        self.textColor = UIColor.JJ_hexColor(colStr).withAlphaComponent(alpha)
    }
}

public extension UIButton {
    
    func JJQuickSetUI(style: String, lanFontType:UIFont.LanHuFont, color:UIColor) {
        let arraySubstrings: [Substring] = style.split(separator: "*")
        
        var size:CGFloat = 14.0
        for item in arraySubstrings {
            if let inSize = Int(item) {
                size = CGFloat(inSize)
            }
        }
        
        setTitleColor(color, for: .normal)
        self.titleLabel?.font = UIFont.lanhu_font(type: lanFontType, size: size)
    }
    
    
    func JJQuickSetUI(style: String, fontType:UIFont.HRFontType, color:UIColor) {
        JJQuickSetUI(style: style, fontType:fontType)
        setTitleColor(color, for: .normal)
    }
    
    // "15*#FFFFFF*0.5"
    func JJQuickSetUI(style: String, fontType:UIFont.HRFontType) {
        let arraySubstrings: [Substring] = style.split(separator: "*")
        
        var size:CGFloat = 14.0
        var alpha:CGFloat = 1.0
        var colStr = "#FFFFFF"
        
        for item in arraySubstrings {
            if let inSize = Int(item) {
                size = CGFloat(inSize)
            } else if item.contains("#") {
                colStr = String(item)
            } else if let inAlpha = Double(item) {
                alpha = CGFloat(inAlpha)
            }
        }
        
        let c = UIColor.JJ_hexColor(colStr).withAlphaComponent(alpha)
        setTitleColor(c, for: .normal)
        
        self.titleLabel?.font = UIFont.JJ_font(type: fontType, size: size)
    }
}

func rgba(_ r:Int,_ g:Int,_ b:Int,_ a:CGFloat) -> UIColor {
    return UIColor(red: CGFloat(r) / 0xff, green: CGFloat(g) / 0xff, blue: CGFloat(b) / 0xff, alpha: a)
}

public extension UIFont {
    enum HRFontType {
        case Ultralight // Extralight
        case Thin       // Light
        case Light      // Regular
        case Regular    // Medium
        case Medium     // bold
        case Semibold   // Heavy
    }
    
    enum LanHuFont {
        case Extralight
        case Light
        case Regular
        case Medium
        case Bold
        case Heavy
    }
    
    static func JJ_font(type: HRFontType, size: CGFloat) -> UIFont {
        switch type {
        case .Ultralight:
            return UIFont(name: "PingFangSC-Ultralight", size: size)!
        case .Thin:
            return UIFont(name: "PingFangSC-Thin", size: size)!
        case .Light:
            return UIFont(name: "PingFangSC-Light", size: size)!
        case .Regular:
            return UIFont(name: "PingFangSC-Regular", size: size)!
        case .Medium:
            return UIFont(name: "PingFangSC-Medium", size: size)!
        case .Semibold:
            return UIFont(name: "PingFangSC-Semibold", size: size)!
        }
    }
    
    // 蓝湖设计稿和实际字体有出入。
    static func lanhu_font(type: LanHuFont, size: CGFloat) -> UIFont {
        switch type {
        case .Extralight:
            return UIFont(name: "PingFangSC-Ultralight", size: size)!
        case .Light:
            return UIFont(name: "PingFangSC-Thin", size: size)!
        case .Regular:
            return UIFont(name: "PingFangSC-Light", size: size)!
        case .Medium:
            return UIFont(name: "PingFangSC-Regular", size: size)!
        case .Bold:
            return UIFont(name: "PingFangSC-Medium", size: size)!
        case .Heavy:
            return UIFont(name: "PingFangSC-Semibold", size: size)!
        }
    }
}

public extension UIColor {
    
    /// UIColor 16进制编码转换RGB
    @objc static func JJ_hexColor(_ ny_hex: String, alpha: CGFloat = 1.0) -> UIColor {
        var hexStr = ny_hex.uppercased()
        if (hexStr.hasPrefix("#")) {
            hexStr = (hexStr as NSString).substring(from: 1)
        }
        let scanner = Scanner(string: hexStr)
        scanner.scanLocation = 0
        var RGBValue: UInt64 = 0
        scanner.scanHexInt64(&RGBValue)
        let r = (RGBValue & 0xff0000) >> 16
        let g = (RGBValue & 0xff00) >> 8
        let b = RGBValue & 0xff
        return UIColor(red: CGFloat(r) / 0xff, green: CGFloat(g) / 0xff, blue: CGFloat(b) / 0xff, alpha: alpha)
    }
    
}
