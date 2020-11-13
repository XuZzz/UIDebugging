//
//  UIKitExtension.swift
//  delinshe_ios
//
//  Created by Xu on 2020/9/28.
//  Copyright © 2020 com.delinshe. All rights reserved.
//

import UIKit

public enum PostingType: String {
    case all = "default"
    case note = "note"
    case value = "value"
    case remove_mines = "remove_mines"
    case dynamic = "no_idea"
    case qa = "interlocution"
}

extension UIViewController {
    
}

// MARK: ShadowLayer
class ShadowLayer: CAShapeLayer {
    @discardableResult
    func setFrame(_ frame: CGRect)-> ShadowLayer {
        self.frame = frame
        return self
    }
    
    @discardableResult
    func setPath(_ path: CGPath)-> ShadowLayer {
        self.shadowPath = path
        return self
    }
    
    @discardableResult
    func setOpacity(_ opacity: Float)-> ShadowLayer {
        self.shadowOpacity = opacity
        return self
    }
    
    @discardableResult
    func setOffset(_ offset: CGSize)-> ShadowLayer {
        self.shadowOffset = offset
        return self
    }
    
    @discardableResult
    func setColor(_ color: UIColor?, alpha: CGFloat = 1.0)-> ShadowLayer {
        if color == nil {
            self.shadowColor = UIColor.black.withAlphaComponent(alpha).cgColor
            return self
        }
        self.shadowColor = color!.withAlphaComponent(alpha).cgColor
        return self
    }
    
    func done()-> UIView {
        let view = UIView(frame: self.frame)
        view.backgroundColor = .clear
        view.layer.insertSublayer(self, at: 0)
        return view
    }
}

// MARK: UIView
extension UIView {
    
//    #if DEBUG
//    @objc open func injected() {
//        print("injected UIView")
//        //find now VC
//        guard let nowVC = UIApplication.shared.keyWindow?.rootViewController else {
//            return
//        }
//        for subV in nowVC.view.subviews {
//            subV.removeFromSuperview()
//        }
//        nowVC.viewDidLoad()
//    }
//    #endif

    /// 部分圆角
    ///
    /// - Parameters:
    ///   - corners: 需要实现为圆角的角，可传入多个
    ///   - radii: 圆角半径
    func corner(byRoundingCorners corners: UIRectCorner, radii: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    
    func setBackgroundGradientColor(colors:[UIColor], startPoint: CGPoint? = nil , endPoint: CGPoint? = nil, locations: [NSNumber]? = nil, cornerRadius: CGFloat) {
        let gradientLayer1 = CAGradientLayer()
        gradientLayer1.frame = self.bounds
        gradientLayer1.colors = colors.map({ (color) -> CGColor in
            return color.cgColor
        })
        var start_point = CGPoint(x: 0, y: 0)
        if startPoint != nil {
            start_point = startPoint!
        }
        var end_point = CGPoint(x: 0, y: 1)
        if endPoint != nil {
            end_point = endPoint!
        }
        
        gradientLayer1.startPoint = start_point
        gradientLayer1.endPoint = end_point
        if locations != nil {
            gradientLayer1.locations = locations!
        }
        gradientLayer1.cornerRadius = cornerRadius
        
        self.layer.insertSublayer(gradientLayer1, at: 0)
    }
    
}

// MARK: UIButton
extension UIButton {
    
    func setGradientColor(colors:[UIColor], startPoint: CGPoint? = nil , endPoint: CGPoint? = nil, locations: [NSNumber]? = nil, cornerRadius: CGFloat) {
        
        let gradientLayer1 = CAGradientLayer()
        gradientLayer1.frame = self.bounds
        gradientLayer1.colors = colors.map({ (color) -> CGColor in
            return color.cgColor
        })
        var start_point = CGPoint(x: 0, y: 0)
        if startPoint != nil {
            start_point = startPoint!
        }
        var end_point = CGPoint(x: 0, y: 1)
        if endPoint != nil {
            end_point = endPoint!
        }
        var loca:[NSNumber] = [0, 1]
        if locations != nil {
            loca = locations!
        }
        gradientLayer1.startPoint = start_point
        gradientLayer1.endPoint = end_point
        gradientLayer1.locations = loca
        gradientLayer1.cornerRadius = cornerRadius
        
        self.layer.addSublayer(gradientLayer1)
        
    }
    
}
// MARK: UITableView
extension UITableView {
    // MARK: - Cell register and reuse
    /**
     Register cell nib
     
     - parameter aClass: class
     */
    func xz_registerCellNib<T: UITableViewCell>(_ aClass: T.Type) {
        let name = String(describing: aClass)
        let nib = UINib(nibName: name, bundle: nil)
        self.register(nib, forCellReuseIdentifier: name)
    }
    
    /**
     Register cell class
     
     - parameter aClass: class
     */
    func xz_registerCellClass<T: UITableViewCell>(_ aClass: T.Type) {
        let name = String(describing: aClass)
        self.register(aClass, forCellReuseIdentifier: name)
    }
    
    /**
     Reusable Cell
     
     - parameter aClass:    class
     
     - returns: cell
     */
    func xz_dequeueReusableCell<T: UITableViewCell>(_ aClass: T.Type) -> T! {
        let name = String(describing: aClass)
        guard let cell = dequeueReusableCell(withIdentifier: name) as? T else {
            fatalError("\(name) is not registed")
        }
        return cell
    }
    
    // MARK: - HeaderFooter register and reuse
    /**
     Register cell nib
     
     - parameter aClass: class
     */
    func xz_registerHeaderFooterNib<T: UIView>(_ aClass: T.Type) {
        let name = String(describing: aClass)
        let nib = UINib(nibName: name, bundle: nil)
        self.register(nib, forHeaderFooterViewReuseIdentifier: name)
    }
    
    /**
     Register cell class
     
     - parameter aClass: class
     */
    func xz_registerHeaderFooterClass<T: UIView>(_ aClass: T.Type) {
        let name = String(describing: aClass)
        self.register(aClass, forHeaderFooterViewReuseIdentifier: name)
    }
    
    /**
     Reusable Cell
     
     - parameter aClass:    class
     
     - returns: cell
     */
    func xz_dequeueReusableHeaderFooter<T: UIView>(_ aClass: T.Type) -> T! {
        let name = String(describing: aClass)
        guard let cell = dequeueReusableHeaderFooterView(withIdentifier: name) as? T else {
            fatalError("\(name) is not registed")
        }
        return cell
    }
}

// MARK: UIImage
extension UIImage {
    func byAlpha(_ alpha: CGFloat)-> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0)
        
        if let ctx = UIGraphicsGetCurrentContext() {
            let area = CGRect(x: 0,
                              y: 0,
                              width: size.width,
                              height: size.height)
            
            ctx.scaleBy(x: 1, y: -1);
            ctx.translateBy(x: 0, y: -area.height)
            ctx.setBlendMode(.multiply)
            ctx.setAlpha(alpha)
            ctx.draw(self.cgImage!, in: area)
            let new = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return new
        }
        return nil
    }
    
}

extension Date {
    /// 获取当前 秒级 时间戳 - 10位
    var timeStamp : String {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        return "\(timeStamp)"
    }
    
    /// 获取当前 毫秒级 时间戳 - 13位
    var milliStamp : String {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval*1000))
        return "\(millisecond)"
    }
}

extension Array {
    subscript (safe index: Int)-> Element? {
        return (0..<count).contains(index) ? self[index] : nil
    }
    
    func isNull()-> Bool {
        if self == nil, self.count <= 0 {
            return true
        }
        return false
    }
}

// 数组切片
extension Sequence {
    func clump(by clumpsize:Int) -> [[Element]] {
        let slices : [[Element]] = self.reduce(into:[]) {
            memo, cur in
            if memo.count == 0 {
                return memo.append([cur])
            }
            if memo.last!.count < clumpsize {
                memo.append(memo.removeLast() + [cur])
            } else {
                memo.append([cur])
            }
        }
        return slices
    }
}


extension String {
    
    /// 转换成阅读数 1w+ 10w+ 999w+
    var convertToReadNumber: String {
        if let number = self.toFloat() {
            if number >= 10000 && number < 10000000 {
                return String(format: "%.1fw", number)
            }else {
                if number >= 10000000 {
                    return "999w"
                }
                return String(format: "%.f", number)
            }
        }
        return self
    }

    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    /// 生成随机字符串
    ///
    /// - Parameters:
    ///   - count: 生成字符串长度
    ///   - isLetter: false=大小写字母和数字组成，true=大小写字母组成，默认为false
    /// - Returns: String
    static func random(_ count: Int, _ isLetter: Bool = false) -> String {
        
        var ch: [CChar] = Array(repeating: 0, count: count)
        for index in 0..<count {
            
            var num = isLetter ? arc4random_uniform(58)+65:arc4random_uniform(75)+48
            if num>57 && num<65 && isLetter==false { num = num%57+48 }
            else if num>90 && num<97 { num = num%90+65 }
            
            ch[index] = CChar(num)
        }
        
        return String(cString: ch)
    }
    
    static func currenTimeStampString()-> String {
        let date = Date()
        let stamp = date.timeIntervalSince1970
        return String(stamp)
    }
    
    
    func toInt() -> Int? {
        return Int(self)
    }
    
    func toFloat() -> Float? {
        return Float(self)
    }
    
    func toDouble() -> Double? {
        return Double(self)
    }
    
    //MARK:- 去除字符串两端的空白字符
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
    func subString(to: Int) -> String {
        var to = to
        if to > self.count {
            to = self.count
        }
        return String(self.prefix(to))
    }
    
    func subString(from: Int) -> String {
        if from >= self.count {
            return ""
        }
        let startIndex = self.index(self.startIndex, offsetBy: from)
        let endIndex = self.endIndex
        return String(self[startIndex..<endIndex])
    }
    
    func subString(start: Int, end: Int) -> String {
        if start < end {
            let startIndex = self.index(self.startIndex, offsetBy: start)
            let endIndex = self.index(self.startIndex, offsetBy: end)
            
            return String(self[startIndex..<endIndex])
        }
        return ""
    }
}

extension UIColor {
    
    /// 文字-白色
    static var app_main_white: UIColor {
        UIColor(hexString: "#FFFFFF")
    }
    
    /// App主基调
    /// 背景色
    static var app_main_background: UIColor {
        UIColor(hexString: "#F8F8F8")
    }
    /// 品牌红色
    static var app_main_red: UIColor {
        UIColor(hexString: "#FF323E")
    }
    /// 品牌绿色
    static var app_main_green: UIColor {
        UIColor(hexString: "#57D975")
    }
    
    /// 标题文字颜色
    static var app_main_title: UIColor {
        UIColor(hexString: "#333333")
    }
    /// 正文颜色
    static var app_main_content: UIColor {
        UIColor(hexString: "#666666")
    }
    /// 辅助信息颜色
    static var app_main_subinfo: UIColor {
        UIColor(hexString: "#999999")
    }
    /// 分割线颜色
    static var app_main_line: UIColor {
        UIColor(hexString: "#F3F3F3")
    }
    
    /// 按钮背景颜色
    static var app_main_buttonBackground: UIColor {
        UIColor(hexString: "#EEEEEE")
    }
    /// 搜素输入框背景颜色
    static var app_main_inputboxBackground: UIColor {
        UIColor(hexString: "#EEEFF3")
    }
    
    static var app_main_thinRed: UIColor {
        UIColor(hexString: "#FF5656")
    }
    
    open class var live_yellow: UIColor {
        get {
            return UIColor(hexString: "#FFC63C")
        }
    }
    
    open class var live_blue: UIColor {
        get {
            return UIColor(hexString: "#66E0E8")
        }
    }
    
    open class var black_25: UIColor {
        get {
            return UIColor(hexString: "#000000").withAlphaComponent(0.25)
        }
    }
    
    open class var cellAnimatedColor: UIColor {
        get {
            return UIColor(hexString: "#f5f5f5")
        }
    }
    
    static func setColor(hex: String, alpha: @autoclosure() -> CGFloat)-> UIColor {
        return UIColor(hexString: hex).withAlphaComponent(alpha())
    }
    
    func createImage(bounds: CGRect)-> UIImage? {
        var image = UIImage()
        UIGraphicsBeginImageContext(bounds.size)
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(self.cgColor)
            context.fill(bounds)
            image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
            UIGraphicsEndImageContext()
        }
        return image
    }
}

extension UIFont {
    static var app_main_big: UIFont {
        .systemFont(ofSize: 18.0)
    }
    
    static var app_main_section: UIFont {
        .systemFont(ofSize: 16.0)
    }
    
    static var app_main_tab: UIFont {
        .systemFont(ofSize: 15.0)
    }
    
    static var app_main_title: UIFont {
        .systemFont(ofSize: 14.0)
    }
    
    static var app_main_content: UIFont {
        .systemFont(ofSize: 13.0)
    }
    
    static var app_main_subinfo: UIFont {
        .systemFont(ofSize: 12.0)
    }
    
    var bold: UIFont {
        .systemFont(ofSize: pointSize, weight: .bold)
    }
    
    var medium: UIFont {
        .systemFont(ofSize: pointSize, weight: .medium)
    }
    
    var regular: UIFont {
        .systemFont(ofSize: pointSize, weight: .regular)
    }

}

