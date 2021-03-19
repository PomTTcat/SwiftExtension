//
//  Date+EX.swift
//  hrloo
//
//  Created by PomCat on 2020/7/1.
//  PomCat
//

import Foundation

public extension Date {
    
    func dateToString(format: String) -> String {
        let dateFomatter = DateFormatter()
        dateFomatter.dateFormat = format
        let currentDateString = dateFomatter.string(from: self)
        return currentDateString
    }
    
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
    
    // 2021/02/18 00:00:00
    var midnight: Date {
        var cal = Calendar.current
        cal.timeZone = TimeZone(identifier: "Asia/Shanghai")!
        return cal.startOfDay(for: self)
    }
    
    // 2021/02/18 12:00:00
    var midday: Date {
        var cal = Calendar.current
        cal.timeZone = TimeZone(identifier: "Asia/Shanghai")!
        return cal.date(byAdding: .hour, value: 12, to: self.midnight)!
    }
}
