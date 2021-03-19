//
//  UIKit+Extension.swift
//  Hedgehog
//
//  Created by JJJ on 2019/11/5.
//  Copyright © 2019 xxx. All rights reserved.
//

import UIKit


class KScreen: NSObject {
    
    static var `default` = KScreen()

    override init() {
        self.kwRatio = kScreenWidth / 375.0
        let h = kScreenHeight - kSafeBottomHeight - kNavigationbarHeight
        self.khRatio = h / 603
        super.init()
    }
    
    private var kwRatio: CGFloat
    private var khRatio: CGFloat
    
    // 用于字体的大小
    static func KGetReallW(_ w: CGFloat) -> CGFloat {
        return w * KScreen.default.kwRatio
    }

    static func KGetReallH(_ h: CGFloat) -> CGFloat {
        return h * KScreen.default.khRatio
    }
}

@objc public extension UIScreen {
    
    @objc static let SCREEN_W_4: CGFloat  = 320.0;
    @objc static let SCREEN_H_4: CGFloat  = 480.0;
    @objc static let SCREEN_W_5S: CGFloat = 320.0;
    @objc static let SCREEN_H_5S: CGFloat = 568.0;
    @objc static let SCREEN_W_6: CGFloat  = 375.0;
    @objc static let SCREEN_H_6: CGFloat  = 667.0;
    @objc static let SCREEN_W_6P: CGFloat = 414.0;
    @objc static let SCREEN_H_6P: CGFloat = 736.0;
    @objc static let SCREEN_W_X: CGFloat  = 375.0;//!<iPhoneX屏幕宽度
    @objc static let SCREEN_H_X: CGFloat  = 812.0;//!<iPhoneX屏幕高度
    @objc static let SCREEN_W_XR: CGFloat = 414.0;//!<iPhoneXsMax,iPhoneXR屏幕宽度
    @objc static let SCREEN_H_XR: CGFloat = 896.0;//!<iPhoneXsMax,iPhoneXR屏幕高度
    @objc static let SCREEN_W_12: CGFloat  = 390.0;//!<iPhoneX屏幕宽度
    @objc static let SCREEN_H_12: CGFloat = 844.0;//!<iPhoneXsMax,iPhoneXR屏幕高度
    
    @objc static var kHeight: CGFloat {
        return self.main.bounds.height >  self.main.bounds.width ? self.main.bounds.height : self.main.bounds.width
    }
    @objc static var kWidth: CGFloat {
        return self.main.bounds.height <= self.main.bounds.width ? self.main.bounds.height : self.main.bounds.width
    }
    
    /// 是否是iPhoneX系列(刘海屏)
    @objc static var isiPhoneXMore: Bool {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }
        return false
    }
    
    var hasTopNotch: Bool {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }
        return false
    }
    
    @objc static var isiPhoneSmall: Bool {
        
        // 宽度小于iphone6 小手机
        let kw = min(kWidth, kHeight)
        if kw < SCREEN_W_6 {
            return true
        }

        return false
    }
    
    static var hrScreenTopMargin: CGFloat {
        if UIScreen.isiPhoneXMore {
            return 44 + 44
        } else {
            return 44 + 20
        }
    }
}

public extension UIDevice {
    
    /// iOS、OS机器型号
    static let hr_modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        func mapToDevice(identifier: String) -> String {
            #if os(iOS)
            switch identifier {
            case "iPod5,1":                                 return "iPod Touch 5"
            case "iPod7,1":                                 return "iPod Touch 6"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
            case "iPhone4,1":                               return "iPhone 4s"
            case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
            case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
            case "iPhone7,2":                               return "iPhone 6"
            case "iPhone7,1":                               return "iPhone 6 Plus"
            case "iPhone8,1":                               return "iPhone 6s"
            case "iPhone8,2":                               return "iPhone 6s Plus"
            case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
            case "iPhone8,4":                               return "iPhone SE"
            case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
            case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6":                return "iPhone X"
            case "iPhone11,2":                              return "iPhone XS"
            case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
            case "iPhone11,8":                              return "iPhone XR"
            case "iPhone12,1":                              return "iPhone 11"
            case "iPhone12,3":                              return "iPhone 11 Pro"
            case "iPhone12,5":                              return "iPhone 11 Pro Max"
                
            case "iPhone13,1":                              return "iPhone 12 Mini"
            case "iPhone13,2":                              return "iPhone 12"
            case "iPhone13,3":                              return "iPhone 12 Pro"
            case "iPhone13,4":                              return "iPhone 12 Pro Max"
                
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
            case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
            case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
            case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
            case "iPad6,11", "iPad6,12":                    return "iPad 5"
            case "iPad7,5", "iPad7,6":                      return "iPad 6"
            case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
            case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
            case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
            case "iPad6,3", "iPad6,4":                      return "iPad Pro (9.7-inch)"
            case "iPad6,7", "iPad6,8":                      return "iPad Pro (12.9-inch)"
            case "iPad7,1", "iPad7,2":                      return "iPad Pro (12.9-inch) (2nd generation)"
            case "iPad7,3", "iPad7,4":                      return "iPad Pro (10.5-inch)"
            case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return "iPad Pro (11-inch)"
            case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return "iPad Pro (12.9-inch) (3rd generation)"
            case "AppleTV5,3":                              return "Apple TV"
            case "AppleTV6,2":                              return "Apple TV 4K"
            case "AudioAccessory1,1":                       return "HomePod"
            case "i386", "x86_64":                          return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default:                                        return identifier
            }
            #elseif os(tvOS)
            switch identifier {
            case "AppleTV5,3": return "Apple TV 4"
            case "AppleTV6,2": return "Apple TV 4K"
            case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
            default: return identifier
            }
            #endif
        }
        
        return mapToDevice(identifier: identifier)
    }()
    
}

public extension Bundle {
    
}

public extension UIView {
    
    /// x
    @objc var hr_x: CGFloat {
        get { return frame.origin.x }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.x    = newValue
            frame                 = tempFrame
        }
    }
    
    /// y
    @objc var hr_y: CGFloat {
        get { return frame.origin.y }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.y    = newValue
            frame                 = tempFrame
        }
    }
    
    /// height
    @objc var hr_height: CGFloat {
        get { return frame.size.height }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.height = newValue
            frame                 = tempFrame
        }
    }
    
    /// width
    @objc var hr_width: CGFloat {
        get { return frame.size.width }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.width  = newValue
            frame = tempFrame
        }
    }
    
    /// size
    @objc var hr_size: CGSize {
        get { return frame.size }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size        = newValue
            frame                 = tempFrame
        }
    }
    
    /// centerX
    @objc var hr_centerX: CGFloat {
        get { return center.x }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.x            = newValue
            center                  = tempCenter
        }
    }
    
    /// centerY
    @objc var hr_centerY: CGFloat {
        get { return center.y }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.y            = newValue
            center                  = tempCenter;
        }
    }
    
    /// bottom
    @objc var hr_bottom: CGFloat {
        get { return hr_y + hr_height }
        set(newVal) {
            hr_y = newVal - hr_height
        }
    }
    
    @objc func JJRoundingCorners(size: CGSize, corners: UIRectCorner, cornerRadii: CGSize) {
        let bezierPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: size.width, height: size.height), byRoundingCorners: corners, cornerRadii: cornerRadii)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezierPath.cgPath
        self.layer.mask = shapeLayer
    }
    
    /// 设置阴影
    @objc func setShadow(shadowColor: UIColor, offset: CGSize,
                   opacity: Float , radius: CGFloat) {
        //设置阴影颜色
        self.layer.shadowColor = shadowColor.cgColor
        //设置透明度
        self.layer.shadowOpacity = opacity
        //设置阴影半径
        self.layer.shadowRadius = radius
        //设置阴影偏移量
        self.layer.shadowOffset = offset
    }
    

}

public extension UIView {

    /** 部分圆角
     * - corners: 需要实现为圆角的角，可传入多个
     * - radii: 圆角半径
     */
    /*
     self.topBackgroundView.corner(byRoundingCorners: [UIRectCorner.topLeft,UIRectCorner.topRight],
                                   radii: r,
                                   with: CGRect(x: 0, y: 0, width: kScreenWidth, height: 80))
     */
    func corner(byRoundingCorners corners: UIRectCorner, radii: CGFloat, with bounds: CGRect) {
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    // smsCodeBtn.corner(byRoundingCorners: [UIRectCorner.bottomRight,UIRectCorner.topRight], radii: 5)
    func corner(byRoundingCorners corners: UIRectCorner, radii: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }

}

public extension UIView {
    @discardableResult
    func applyGradient(colours: [UIColor]) -> CAGradientLayer {
        return self.applyGradient(colours: colours, locations: nil)
    }

    // 横着 [(0), (1)]
    @discardableResult
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }
}

public extension CAGradientLayer {
    
    // https://www.cnblogs.com/youxianming/p/3793913.html
    // direction 0: 水平 direction 1：垂直
    static func loadWithleftColor(_ c: UIColor, rightColor: UIColor, direction: Int) -> CAGradientLayer {
        let topColor = c
        let buttomColor = rightColor
        //将颜色和颜色的位置定义在数组内
        let gradientColors: [CGColor] = [topColor.cgColor, buttomColor.cgColor]
        let gradientLocations: [NSNumber] = [(0), (1)]

        //创建CAGradientLayer实例并设置参数
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations
        
        if direction == 0 {
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        } else if direction == 1 {
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        }

        return gradientLayer
    }
    
}

public extension UIColor {
        
    /// RGB形式转换Color
    @objc static func JJ_rgbColor(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: alpha)
    }
    
    static func JJ_random() -> UIColor {
        return UIColor(red: CGFloat(Float.random(in: (0...255.00))/255.0), green: CGFloat(Float.random(in: (0...255.00))/255.0), blue: CGFloat(Float.random(in: (0...255.0))/255.0), alpha: 1.0)
    }
    
    /// 主题色
    static func JJ_themeColor() -> UIColor {
 
        return UIColor.JJ_hexColor("#29A1F7")
    }
    
    /// 一级文本颜色: 一级信息，标题、主内容文字
    static func JJ_textColor() -> UIColor {
        return UIColor.JJ_hexColor("#29A1F7")
    }
    
    static func JJ_selectTextColor() -> UIColor {
        return UIColor.JJ_hexColor("#29A1F7")
    }
    
    /// 二级文本颜色：普通级别文字，正文内容文字
    static func JJ_secondTextColor() -> UIColor {
        return UIColor.JJ_hexColor("#616266")
    }
    
    /// 辅助文本颜色：辅助文字、次要信息
    static func JJ_assistTextColor() -> UIColor {
        return UIColor.JJ_hexColor("#D3D5DC")
    }
    
    /// 占位文本颜色：小段描述文字，占位提示文字
    static func JJ_placeholdTextColor() -> UIColor {
        return UIColor.JJ_hexColor("#BFC1CD")
    }
    
    /// 分割线背景色：分割线
    static func JJ_splitLineColor() -> UIColor {
        return UIColor.JJ_hexColor("#F9F9F9")
    }
    
    /// 按钮边框颜色
    static func JJ_buttonBorderColor() -> UIColor {
        return UIColor.JJ_hexColor("#E7E8E9")
    }
    
    /// 按钮不可用背景色
    static func JJ_buttonDisableColor() -> UIColor {
        return UIColor.JJ_hexColor("#E7E8EA")
    }
    
    /// 全局控制器背景色
    static func JJ_viewControllerBackgroundColor() -> UIColor {
        return UIColor.JJ_hexColor("#F9F9F9")
    }
    
    /// 通用红色
    static func JJ_redColor() -> UIColor {
        return UIColor.JJ_hexColor("#E2353D")
    }
    
    //MARK: 直播
    /// 直播页面主色调
    static func JJ_liveMainColor() -> UIColor {
        return UIColor.JJ_hexColor("#161922")
    }

    static func JJ_liveNameColor() -> UIColor {
        return UIColor.JJ_hexColor("#29A1F7")
    }
    
    static func JJ_liveTextColor() -> UIColor {
        return UIColor.JJ_hexColor("#DCDEE5")
    }
    
    /// base
 
    
    static func JJColor51() -> UIColor {
        return rgba(51, 51, 51, 1)
    }
    
    static func JJColor102() -> UIColor {
        return rgba(102, 102, 102, 1)
    }
    
    static func JJColor211() -> UIColor {
        return rgba(211, 211, 211, 1)
    }
    
    static func JJColor232() -> UIColor {
        return rgba(232, 232, 232, 1)
    }
    
    static func JJOrigin() -> UIColor {
        return rgba(255, 144, 0, 1)
    }

}



@objc public extension UILabel {
    
    /// 自定义UILabel初始化
    @objc convenience init(text: String? = nil, textColor: UIColor? = nil, font: UIFont? = nil, bgColor: UIColor? = nil) {
        
        self.init()
        //设置标题颜色
        if let color = textColor {
            self.textColor = color
        }
        // 设置文本
        if let textStr = text {
            self.text = textStr
        }
        //设置字体
        if let fontResult = font {
            self.font = fontResult
        }
        //设置背景颜色
        if let bgColorResult = bgColor {
            self.backgroundColor = bgColorResult
        }
        
    }
    
    /**
     * 富文本设置
     * @param
     *  fullStr 完整的text
     *  first* 设置第一部分的Str
     *  other* 设置其他部分的Str
     *  不设置的地方为UILabel原本的设置方法
     */
    @objc func customAttributedText(fullStr: String, firstSetStr: String? = nil, firstFont: UIFont? = nil, firstColor: UIColor? = nil, firstBgColor: UIColor? = nil, otherSetStr: String? = nil, otherFont: UIFont? = nil, otherColor: UIColor? = nil, otherBgColor: UIColor? = nil) {
        
        let string = fullStr
        
        let result = NSMutableAttributedString(string: string)
        //设置iOS的字体属性
        
        if firstSetStr != nil {
            var attributesForFirstWord = [NSAttributedString.Key: Any]()
            if let tempFont = firstFont {
                attributesForFirstWord[.font] = tempFont
            }
            if let tempColor = firstColor {
                attributesForFirstWord[.foregroundColor] = tempColor
            }
            if let tempBgColor = firstBgColor {
                attributesForFirstWord[.backgroundColor] = tempBgColor
            }
            result.setAttributes(attributesForFirstWord, range:(string as NSString).range(of: firstSetStr!) )
        }
        
        
        if otherSetStr != nil {
            var attributesForSecondWord = [NSAttributedString.Key : Any]()
            if let tempFont = otherFont {
                attributesForSecondWord[.font] = tempFont
            }
            if let tempColor = otherColor {
                attributesForSecondWord[.foregroundColor] = tempColor
            }
            if let tempBgColor = otherBgColor {
                attributesForSecondWord[.backgroundColor] = tempBgColor
            }
            result.setAttributes(attributesForSecondWord , range: (string as NSString).range(of: otherSetStr!))
        }
        self.attributedText = NSAttributedString(attributedString: result)
        
    }
    
}



@objc public extension UIApplication {
    
    /// 拿到window
    @objc func mainWindow() -> UIWindow? {
        return self.delegate?.window ?? nil
    }
    
    /// 拿到当前VC
    @objc func visibleVC() -> UIViewController {
        let rootVC = self.mainWindow()?.rootViewController
        return self.getVisibleVCWith(vc: rootVC ?? UIViewController())
    }
    
    /// 匹配当前VC
    @objc func getVisibleVCWith(vc: UIViewController) -> UIViewController {
        
        if vc.isKind(of: UINavigationController.classForCoder()) {
            return self.getVisibleVCWith(vc: (vc as? UINavigationController)?.visibleViewController ?? UIViewController())
            
        } else if vc.isKind(of: UITabBarController.classForCoder()) {
            return self.getVisibleVCWith(vc: (vc as? UITabBarController)?.selectedViewController ?? UIViewController())
        } else {
            if vc.presentedViewController != nil {
                return self.getVisibleVCWith(vc: vc.presentedViewController ?? UIViewController())
            } else {
                return vc
            }
        }
    }
    
    /// 方法取NC
    @objc func visibleNC() -> UINavigationController {
        return self.visibleVC().navigationController ?? UINavigationController()
    }
}

public extension UIImage {
    
    /// let img = UIImage.from(color: .black)
    static func from(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
    
    
    /// 返回的是byte数量
    var byteSize: Int {
        return NSData(data: jpegData(compressionQuality: 1) ?? Data()).count
    }
    
    /// SwifterSwift: UIImage with .alwaysOriginal rendering mode.
    var original: UIImage {
        return withRenderingMode(.alwaysOriginal)
    }

    /// SwifterSwift: UIImage with .alwaysTemplate rendering mode.
    var template: UIImage {
        return withRenderingMode(.alwaysTemplate)
    }
    
    /// 指定尺寸进行压缩
    /// - Parameter width: 目标宽度
    func compress(targetWidth width: CGFloat) -> UIImage? {
        let imageSize = self.size
        let height = (width / imageSize.width) * imageSize.height
        UIGraphicsBeginImageContext(CGSize(width: width, height: height))
        self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    
    /// SwifterSwift: Create UIImage from color and size.
    ///
    /// - Parameters:
    ///   - color: image fill color.
    ///   - size: image size.
    convenience init(color: UIColor, size: CGSize) {
        UIGraphicsBeginImageContextWithOptions(size, false, 1)

        defer {
            UIGraphicsEndImageContext()
        }

        color.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))

        guard let aCgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {
            self.init()
            return
        }

        self.init(cgImage: aCgImage)
    }

//    static func createImage(_ color: UIColor)-> UIImage{
//        let rect = CGRect.init(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
//        UIGraphicsBeginImageContext(rect.size)
//        let context = UIGraphicsGetCurrentContext()
//        context?.setFillColor(color.cgColor)
//        context?.fill(rect)
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return image!
//    }
    
    
    /// SwifterSwift: Compressed UIImage from original UIImage.
    ///
    /// - Parameter quality: The quality of the resulting JPEG image, expressed as a value from 0.0 to 1.0. The value 0.0 represents the maximum compression (or lowest quality) while the value 1.0 represents the least compression (or best quality), (default is 0.5).
    /// - Returns: optional UIImage (if applicable).
    func compressed(quality: CGFloat = 0.5) -> UIImage? {
        guard let data = compressedData(quality: quality) else { return nil }
        return UIImage(data: data)
    }

    /// SwifterSwift: Compressed UIImage data from original UIImage.
    ///
    /// - Parameter quality: The quality of the resulting JPEG image, expressed as a value from 0.0 to 1.0. The value 0.0 represents the maximum compression (or lowest quality) while the value 1.0 represents the least compression (or best quality), (default is 0.5).
    /// - Returns: optional Data (if applicable).
    func compressedData(quality: CGFloat = 0.5) -> Data? {
        return jpegData(compressionQuality: quality)
    }

    /// SwifterSwift: UIImage Cropped to CGRect.
    ///
    /// - Parameter rect: CGRect to crop UIImage to.
    /// - Returns: cropped UIImage
    func cropped(to rect: CGRect) -> UIImage {
        guard rect.size.width <= size.width && rect.size.height <= size.height else { return self }
        guard let image: CGImage = cgImage?.cropping(to: rect) else { return self }
        return UIImage(cgImage: image)
    }

    /// SwifterSwift: UIImage scaled to height with respect to aspect ratio.
    ///
    /// - Parameters:
    ///   - toHeight: new height.
    ///   - opaque: flag indicating whether the bitmap is opaque.
    /// - Returns: optional scaled UIImage (if applicable).
    func scaled(toHeight: CGFloat, opaque: Bool = false) -> UIImage? {
        let scale = toHeight / size.height
        let newWidth = size.width * scale
        UIGraphicsBeginImageContextWithOptions(CGSize(width: newWidth, height: toHeight), opaque, self.scale)
        draw(in: CGRect(x: 0, y: 0, width: newWidth, height: toHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

    /// SwifterSwift: UIImage scaled to width with respect to aspect ratio.
    ///
    /// - Parameters:
    ///   - toWidth: new width.
    ///   - opaque: flag indicating whether the bitmap is opaque.
    /// - Returns: optional scaled UIImage (if applicable).
    func scaled(toWidth: CGFloat, opaque: Bool = false) -> UIImage? {
        let scale = toWidth / size.width
        let newHeight = size.height * scale
        UIGraphicsBeginImageContextWithOptions(CGSize(width: toWidth, height: newHeight), opaque, self.scale)
        draw(in: CGRect(x: 0, y: 0, width: toWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

    /// SwifterSwift: Creates a copy of the receiver rotated by the given angle.
    ///
    ///     // Rotate the image by 180°
    ///     image.rotated(by: Measurement(value: 180, unit: .degrees))
    ///
    /// - Parameter angle: The angle measurement by which to rotate the image.
    /// - Returns: A new image rotated by the given angle.
    @available(iOS 10.0, tvOS 10.0, watchOS 3.0, *)
    func rotated(by angle: Measurement<UnitAngle>) -> UIImage? {
        let radians = CGFloat(angle.converted(to: .radians).value)

        let destRect = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: radians))
        let roundedDestRect = CGRect(x: destRect.origin.x.rounded(),
                                     y: destRect.origin.y.rounded(),
                                     width: destRect.width.rounded(),
                                     height: destRect.height.rounded())

        UIGraphicsBeginImageContext(roundedDestRect.size)
        guard let contextRef = UIGraphicsGetCurrentContext() else { return nil }

        contextRef.translateBy(x: roundedDestRect.width / 2, y: roundedDestRect.height / 2)
        contextRef.rotate(by: radians)

        draw(in: CGRect(origin: CGPoint(x: -size.width / 2,
                                        y: -size.height / 2),
                        size: size))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

    /// SwifterSwift: Creates a copy of the receiver rotated by the given angle (in radians).
    ///
    ///     // Rotate the image by 180°
    ///     image.rotated(by: .pi)
    ///
    /// - Parameter radians: The angle, in radians, by which to rotate the image.
    /// - Returns: A new image rotated by the given angle.
    func rotated(by radians: CGFloat) -> UIImage? {
        let destRect = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: radians))
        let roundedDestRect = CGRect(x: destRect.origin.x.rounded(),
                                     y: destRect.origin.y.rounded(),
                                     width: destRect.width.rounded(),
                                     height: destRect.height.rounded())

        UIGraphicsBeginImageContext(roundedDestRect.size)
        guard let contextRef = UIGraphicsGetCurrentContext() else { return nil }

        contextRef.translateBy(x: roundedDestRect.width / 2, y: roundedDestRect.height / 2)
        contextRef.rotate(by: radians)

        draw(in: CGRect(origin: CGPoint(x: -size.width / 2,
                                        y: -size.height / 2),
                        size: size))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

    /// SwifterSwift: UIImage filled with color
    ///
    /// - Parameter color: color to fill image with.
    /// - Returns: UIImage filled with given color.
    func filled(withColor color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.setFill()
        guard let context = UIGraphicsGetCurrentContext() else { return self }

        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(CGBlendMode.normal)

        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        guard let mask = cgImage else { return self }
        context.clip(to: rect, mask: mask)
        context.fill(rect)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }

    /// SwifterSwift: UIImage tinted with color
    ///
    /// - Parameters:
    ///   - color: color to tint image with.
    ///   - blendMode: how to blend the tint
    /// - Returns: UIImage tinted with given color.
    func tint(_ color: UIColor, blendMode: CGBlendMode) -> UIImage {
        let drawRect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer {
            UIGraphicsEndImageContext()
        }
        let context = UIGraphicsGetCurrentContext()
        color.setFill()
        context?.fill(drawRect)
        draw(in: drawRect, blendMode: blendMode, alpha: 1.0)
        return UIGraphicsGetImageFromCurrentImageContext()!
    }

    /// SwifterSwift: UIImage with rounded corners
    ///
    /// - Parameters:
    ///   - radius: corner radius (optional), resulting image will be round if unspecified
    /// - Returns: UIImage with all corners rounded
    func withRoundedCorners(radius: CGFloat? = nil) -> UIImage? {
        let maxRadius = min(size.width, size.height) / 2
        let cornerRadius: CGFloat
        if let radius = radius, radius > 0 && radius <= maxRadius {
            cornerRadius = radius
        } else {
            cornerRadius = maxRadius
        }

        UIGraphicsBeginImageContextWithOptions(size, false, scale)

        let rect = CGRect(origin: .zero, size: size)
        UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
        draw(in: rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    /// 压缩图片至maxKB以下
    func JJCustomCompress(maxKB: Int = 1024, mulriple: CGFloat = 2) -> Data? {
        let quality = recursionDecrease(maxKB: maxKB, mulriple: mulriple)
        return jpegData(compressionQuality: quality)
    }
    
    func recursionDecrease(maxKB: Int = 1024, mulriple: CGFloat = 2) -> CGFloat {
        let maxKB = maxKB * 1024
        var quality: CGFloat = 0.98 //其实质量0.98 就能节省50%大小
        var goCaculate = true
        while goCaculate {
            let imgData = NSData(data: self.jpegData(compressionQuality: quality) ?? Data())
            let imageSize: Int = imgData.count
            
            if imageSize <= maxKB {
                goCaculate = false
            } else {
                quality = quality / mulriple
            }
        }
        
        return quality
    }
    
    static func JJ_navigationBarBackgroundImage() -> UIImage {
        return UIImage.init(color: UIColor.white, size: CGSize(width: 1, height: 1))
    }
}

public extension Date {
    static var dateFormat: DateFormatter {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = JJDateFormat
        
        return dateFormat
    }
    
    static func dateFrom(string: String) -> Date? {
        return dateFormat.date(from: string)
    }
    
    static func stringFrom(date: Date?) -> String? {
        guard let newDate = date else { return nil }
        return dateFormat.string(from: newDate)
    }
    
    /// 天数差
    /// - Parameter toDate: 未来时间
    /// - Returns: 天数差
    func daysBetweenDate(toDate: Date) -> Int {
        let components = Calendar.current.dateComponents([.day], from: self, to: toDate)
        return components.day ?? 0
    }
    
    var JJunixTimestamp: Double {
        return timeIntervalSince1970
    }
    
    func JJstring(withFormat format: String = "dd/MM/yyyy HH:mm") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}


public extension UINavigationController {
    
    func popToRootViewController(animated: Bool, completion: @escaping () -> Void) {
        popToRootViewController(animated: animated)
        
        if animated, let coordinator = transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion()
            }
        } else {
            completion()
        }
    }
}

