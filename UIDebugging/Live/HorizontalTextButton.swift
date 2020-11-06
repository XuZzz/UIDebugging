//
//  HorizontalTextButton.swift
//  UIDebugging
//
//  Created by Xu on 2020/11/5.
//

import UIKit

class HorizontalTextButton: UIButton {
    var topTitle: String = ""
    var bottomTitle: String = ""
    
    var topFont: UIFont?
    var bottomFont: UIFont?
    
    var topColor: UIColor?
    var bottomColor: UIColor?
    
    var lines: Int = 3
    
    open func setText() {
        
        var changeLine = ""
        if lines > 2 {
            for i in 2..<lines {
                print(i)
                changeLine.append("\n")
            }
        }
        let topAttr = NSMutableAttributedString(string: topTitle + changeLine)
        let bottomAttr = NSMutableAttributedString(string: bottomTitle)
        let topRange = NSRange(location: 0, length: topTitle.count)
        let bottomRange = NSRange(location: 0, length: bottomTitle.count)
        let para = NSMutableParagraphStyle()
        
        para.lineSpacing = 6
        para.alignment = .center
        topAttr.addAttribute(.foregroundColor,
                             value: topColor ?? .black,
                             range: topRange)
        topAttr.addAttribute(.font,
                             value: topFont ?? UIFont.app_main_title.medium,
                             range: topRange)
        topAttr.addAttribute(.paragraphStyle, value: para, range: topRange)
        
        bottomAttr.addAttribute(.foregroundColor,
                                value: bottomColor ?? .black,
                                range: bottomRange)
        bottomAttr.addAttribute(.font,
                                value: bottomFont ?? UIFont.app_main_content.medium,
                                range: bottomRange)
        bottomAttr.addAttribute(.paragraphStyle, value: para, range: bottomRange)
        
        let attr = NSMutableAttributedString(attributedString: topAttr)
        attr.append(bottomAttr)
        titleLabel?.numberOfLines = lines
        setAttributedTitle(attr,
                           for: .normal)
    }
}
