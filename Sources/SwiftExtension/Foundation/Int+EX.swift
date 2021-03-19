//
//  Int+EX.swift
//  SwiftExtension
//
//  Created by PomCat on 2021/3/19.
//

import Foundation

public extension Int {
    
    // 123 -> 123
    // 1234 -> 1,234
    var str3Margin: String {
        
        let price = self as NSNumber
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        if let p = formatter.string(from: price) {
            return "\(p)"
        } else {
            return "\(self)"
        }
    }
    
    /*
     let price = model.ableRMB as NSNumber
     let formatter = NumberFormatter()
     formatter.numberStyle = .decimal
     formatter.minimumFractionDigits = 2
     formatter.maximumFractionDigits = 2
     
     if let p = formatter.string(from: price) {
     topView.cashLabel.text = "￥\(p)"
     } else {
     topView.cashLabel.text = "￥\(0)"
     }
     */

}

public let JJDateFormat = "MMMM dd,yyyy HH:mm:ss"

public extension Int {
    /// 时间戳:单位微妙 -> 日期字符串
    /// - Parameter dateFormat: 日期格式
    func millSecondConvertToDateString(withDateFormat dateFormat: String = JJDateFormat) -> String? {
        let dateString = Date(timeIntervalSince1970: TimeInterval(self / 1000)).JJstring(withFormat: dateFormat)
        return dateString
    }
    
    func secondConvertToDateString(withDateFormat dateFormat: String = JJDateFormat) -> String? {
        let dateString = Date(timeIntervalSince1970: TimeInterval(self)).JJstring(withFormat: dateFormat)
        return dateString
    }


    /// 返回当前时间和目标时间的差距。 > 0 ,就是时间还没有结束
    /// - Parameter endTime: 目标时间
    /// - Returns: gap
    static func currentTimeGap(_ endTime: Int?) -> Int {
        let ct = Int((Date().JJunixTimestamp ) * 1000)
        let gaptime = ((endTime ?? ct) - ct) / 1000
        return gaptime
    }

    static func afterTimeInt(second: Int) -> Int {
        let ct = Int((Date().JJunixTimestamp ) * 1000)
        return ct + (second * 1000)
    }
}

public extension Int {
    
    /// 用于显示的最大字符串
    /// - Parameter max: max = 99 self = 1000- > 99+    self = 10 return 10
    func maxShowString(max: Int) -> String {
        var i = ""
        if self > max {
            i = "\(max)+"
        } else {
            i = "\(self)"
        }
        
        return i
    }
    
}
