
import Foundation
//import SwifterSwift

public extension String {
    /// 正则匹配手机号
    var isMobile: Bool {
        /**
         * 手机号码
         * 移动：134 135 136 137 138 139 147 148 150 151 152 157 158 159  165 172 178 182 183 184 187 188 198
         * 联通：130 131 132 145 146 155 156 166 171 175 176 185 186
         * 电信：133 149 153 173 174 177 180 181 189 199
         * 虚拟：170
         */
//        return isMatch("^(1[3-9])\\d{9}$")
        
        // TODO: 支持国际手机号，每开通一个国家就增加一个国家的手机号匹配
        return (isChinaPhone() || isAmericanPhone())
    }
    
    /// 正则匹配用户身份证号15或18位
    var isUserIdCard: Bool {
        return isMatch("(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)")
    }
    
    /// 正则匹配密码为8-20位，且必须由字母、数字、符号两种或以上组成
    /// 6 位以上字符
    var isPassword: Bool {
//        return isMatch("^(?![\\d]+$)(?![a-zA-Z]+$)(?![^\\da-zA-Z]+$).{8,20}$")
        return isMatch("^[\\da-zA-Z0-9]{6,20}$")
    }
    
    /// 正则匹配交易密码为6位，必须由数字组成
    var isTransactionPassword: Bool {
        return isMatch("^[0-9]{6}$")
    }
    
    /// 正则匹配URL
    var isURL: Bool {
        return isMatch("^[0-9A-Za-z]{1,50}")
    }
    
    /// 正则匹配用户姓名,20位的中文或英文
   var isUserName: Bool {
        return isMatch("^[a-zA-Z\\u4E00-\\u9FA5]{1,20}")
    }
    
    /// 正则匹配用户email
    var isEmail: Bool {
        return isMatch("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}")
    }
    
    /// 正则匹配推荐码（三位字母，三位数字）
    var isReferralCode: Bool {
//        return isMatch("[A-Za-z]{3}[0-9]{3}+$")
        return count == 6
    }
    
    /// 判断是否都是数字
    var isNumber: Bool {
        return isMatch("^[0-9]*$")
    }
    
    /// 只能输入由26个英文字母组成的字符串
    var isLetter: Bool {
        return isMatch("^[A-Za-z]+$")
    }
    
    /// 判断是否都是数字和英文
    var isNumberAndLetter: Bool {
        return isMatch("^[0-9A-Za-z]*$")
    }
    
    /// 9 位纯数字
    var isSSN: Bool {
        return isMatch("^[0-9]{9}$")
    }
    
    /// 是否是 zipCode, 数字及“-”组合
    var isZipCode: Bool {
        return isMatch("^[0-9]{5}(?:-[0-9]{4})?$")
    }
    
    /// 是否是金额输入
    var isPrize: Bool {
        return isMatch("^[0-9]+([.]{1}[0-9]+){0,1}$")
    }
    
    private func isMatch(_ pred: String ) -> Bool {
        let pred = NSPredicate(format: "SELF MATCHES %@", pred)
        let isMatch: Bool = pred.evaluate(with: self)
        return isMatch
    }
    
    func isChinaPhone() -> Bool {
        var phone = removingPrefix("+86")
        return phone.trim().isMatch("^(1[3-9])\\d{9}$")
    }
    
    private func removingPrefix(_ prefix: String) -> String {
        guard hasPrefix(prefix) else { return self }
        return String(dropFirst(prefix.count))
    }
    
    private mutating func trim() -> String {
        self = trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return self
    }
    
    private func isAmericanPhone() -> Bool {
        var phone = self
        // 如果没有 +1 开头
        if !hasPrefix("+1") {
            phone = "+1" + self
        }
        return phone.isMatch("^(\\+?1)?[2-9]\\d{2}[2-9](?!11)\\d{6}$")
    }
    
    var isBlank: Bool {
        let trimmedStr = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedStr.isEmpty
    }
}

public extension String {

    func indexInt(of char: Character) -> Int? {
        return firstIndex(of: char)?.utf16Offset(in: self)
    }
    
    // 包括符号本身
    // "Hello.World" -> "Hello"
    func cutAfter(of char: Character) -> String {
        if let i = self.indexInt(of: char){
            return String(self.prefix(i))
        } else {
            return self
        }
    }
    
    func index(of element: Character) -> Int {
        if let range: Range<String.Index> = self.range(of: ".") {
            let index: Int = self.distance(from: self.startIndex, to: range.lowerBound)
            return index
        }
        else {
            return -1
        }
    }
    
    static func RegularExpression(regex: String, validateString: String) -> Int {
        do {
            let RE = try NSRegularExpression(pattern: regex, options: .caseInsensitive)
            let matchs = RE.matches(in: validateString, options: .reportProgress, range: NSRange(location: 0, length: validateString.count))
            return matchs.count
        }
        catch {
            return -1
        }
    }
    
    /// 使得数额有效。小数点后最多两位。
    /// .1 -> 0.1       .. -> .     1.232 -> 1.23
    /// 12.23. -> 12.23     12.11232 -> 12.11   ｜ 02 -> 2
    static func makeTextPriceAvailable(_ text: String) -> String {
        
        if text == "" {
            return text
        }
        
        guard text.contains(".") else {
            return String(Int(text) ?? 0)
        }
        
        let needAddZeroRegex = "^\\.[0-9]$" // match 1,加0
        let legalTextRegex = "^[0-9]+\\.[0-9]{0,2}$" // match 1 返回原值
        
        let needAddZero = String.RegularExpression(regex: needAddZeroRegex, validateString: text)
        if needAddZero == 1 {
            return "0" + text
        }
        
        let isLegal = String.RegularExpression(regex: legalTextRegex, validateString: text)
        if isLegal == 1 {
            return text
        }
        
        //获取第一个. 所在的位置
        let dotIndex = text.index(of: ".")
        let cutIndex = dotIndex + 3

        // 如果1.2123 移除多个char   6 > 4  6 > 5
        if text.count > cutIndex {
            return String(text[..<text.index(text.startIndex, offsetBy: cutIndex)])
        } else {
            return String(text.dropLast())
        }
    }
}


public extension String {
    func JJ_date(withFormat format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }

}

public extension String {
    var dic: [String: Any]? {
        get {
            if let data = self.data(using: .utf8) {
                do {
                    return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                } catch {
                    print(error.localizedDescription)
                }
            }
            return nil
        }
    }
}


public extension Date {
    /// SwifterSwift: Date string from date.
    ///
    ///     Date().string(withFormat: "dd/MM/yyyy") -> "1/12/17"
    ///     Date().string(withFormat: "HH:mm") -> "23:50"
    ///     Date().string(withFormat: "dd/MM/yyyy HH:mm") -> "1/12/17 23:50"
    ///
    /// - Parameter format: Date format (default is "dd/MM/yyyy").
    /// - Returns: date string.
    func JJ_string(withFormat format: String = "dd/MM/yyyy HH:mm") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
    
    
    static func milliStampGap(start: Date,finish: Date) -> Int64 {
        return finish.hr_milliStamp - start.hr_milliStamp
    }
    
    /// 获取当前 秒级 时间戳 - 10位
    var hr_timeStamp : Int {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        return timeStamp
    }
    
    /// 获取当前 毫秒级 时间戳 - 13位
    // HRLog("------JEFF happen milliStamp = \(Date().hr_milliStamp)")
    var hr_milliStamp : Int64 {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval*1000))
        return millisecond
    }
    
}


public extension Dictionary {
    
//    var toJSONString : String {
//        get {
//            guard let data = self.jsonData() else { return "" }
//            guard let json = String(data: data, encoding: String.Encoding.utf8) else { return "" }
//            return json
//        }
//
//    }
    
    func percentEncoded() -> Data? {
        return map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
    
    

}




public extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="

        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}

public extension Sequence {

    /// 自定义model指定去重: 该函数的参数filterCall是一个带返回值的闭包，传入模型Element，返回一个E类型
    public func filterSame<E: Equatable>(_ filterCall: (Element) -> E) -> [Element] {
        var temp = [Element]()
        for model in self {
            //调用filterCall，获得需要用来判断的属性E
            let identifer = filterCall(model)
            //此处利用map函数 来将model类型数组转换成E类型的数组，以此来判断
            if !temp.map( { filterCall($0) } ).contains(identifer) {
                temp.append(model)
            }
        }
        return temp
    }
}

public extension Data {
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
//        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
//              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
//              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
//
//        return prettyPrintedString
        return "OK"
    }
}

public extension FileManager {
    func removelaunchScreenCache() {
        let filePath = NSHomeDirectory() + "/Library/SplashBoard"
        if fileExists(atPath: filePath) {
            do {
                try removeItem(atPath: filePath)
            } catch  {
                
            }
        }
    }
}

