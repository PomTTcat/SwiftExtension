//
//  Double+EX.swift
//  SwiftExtension
//
//  Created by PomCat on 2021/3/19.
//

import Foundation

public extension Double {
    
    var str2F: String {
        return String(format: "%.2f", self)
    }
    
    // 保留几位浮点数
    func stringWithF(num: Int) {
        let str = String(format: "%.\(num)f", self)
        print(str)
    }
}
