//
//  String+EX.swift
//  hrloo
//
//  Created by PomCat on 2020/7/1.
//  PomCat
//

import Foundation
import UIKit
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG


public extension String {
    

    /**
     * 将字符串每隔数位用分割符隔开
     *
     * @param source 目标字符串
     * @param gap    相隔位数，默认为3
     * @param gap    分割符，默认为逗号
     * @return       用指定分隔符每隔指定位数隔开的字符串
     *
     */
    static func showInComma(source: String, gap: Int=3, seperator: Character=",") -> String {
        var temp = source
        /* 获取目标字符串的长度 */
        let count = temp.count
        /* 计算需要插入的【分割符】数 */
        let sepNum = count / gap
        /* 若计算得出的【分割符】数小于1，则无需插入 */
        guard sepNum >= 1 else {
            return temp
        }
        /* 插入【分割符】 */
        for i in 1...sepNum {
            /* 计算【分割符】插入的位置 */
            let index = count - gap * i
            /* 若计算得出的【分隔符】的位置等于0，则说明目标字符串的长度为【分割位】的整数倍，如将【123456】分割成【123,456】，此时如果再插入【分割符】，则会变成【,123,456】 */
            guard index != 0 else {
                break
            }
            /* 执行插入【分割符】 */
            temp.insert(seperator, at: temp.index(temp.startIndex, offsetBy: index))
        }
        return temp
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.width)
    }

    var MD5: Data {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        let messageData = self.data(using:.utf8)!
        var digestData = Data(count: length)
        
        _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
            messageData.withUnsafeBytes { messageBytes -> UInt8 in
                if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                    let messageLength = CC_LONG(messageData.count)
                    CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                }
                return 0
            }
        }
        return digestData
    }
    
    // "zzzzzzzzzž".MD5Str
    var MD5Str: String {
        return self.MD5.map { String(format: "%02hhx", $0) }.joined()
    }
    
    // 将原始的url编码为合法的url
    // 除了set中的其他都被编码
    func JJUrlEncoded() -> String {

        let set = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-.")
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters: set)
        return encodeUrlString ?? ""
    }
     
    //将编码后的url转换回原始的url
    func JJUrlDecoded() -> String {
        return self.removingPercentEncoding ?? ""
    }
    
    /// 隐藏中间4位
    /// - Returns: 新号码 13576836715 -> 135****6715
    func phoneNumberHidden() -> String {
        
        if self.count != 11 {
            return self
        }
        
        let startIndex = self.index(self.startIndex, offsetBy:3)
        let endIndex = self.index(startIndex, offsetBy:4)
        let result = self.replacingCharacters(in: startIndex..<endIndex, with:"****")
        return result
    }
}

public extension String {
    var htmlToAttributedString: NSMutableAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)

        } catch {
            return nil
        }
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}




