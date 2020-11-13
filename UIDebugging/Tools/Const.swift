//
//  Const.swift
//  UIDebugging
//
//  Created by 许朕 on 2020/11/9.
//

import Foundation


let placeholderImage = UIImage(named: "启动图标最终版.png")
let placeholderHeadImage = UIImage(named: "默认头像01.png")

let StatusBar_Height = UIApplication.shared.statusBarFrame.size.height
let cd_margin = CGFloat(15)
var is_iPhoneX: Bool {
    var isMore:Bool = false
    if #available(iOS 11.0, *) {
        if let window = UIApplication.shared.delegate?.window {
            if let window = window {
                isMore = window.safeAreaInsets.bottom > 0.0
            }
        }
    }
    return isMore
}
let is_iPhone5 = SCREEN_WIDTH == 320 ? true : false
let is_iPhone6 = SCREEN_WIDTH == 375 ? true : false
let is_iPhone6P = SCREEN_WIDTH == 414 ? true : false

let Tabbar_Height = CGFloat(is_iPhoneX ? 49+34 : 49)
let TabbarSafeBottomMargin = CGFloat(is_iPhoneX ? 34 : 0)
let Nav_Height = CGFloat(is_iPhoneX ? 88 : 64)
let VIEW_HEIGHT = SCREEN_HEIGHT - Nav_Height
let scroll_height = (SCREEN_WIDTH-30)*(160.0/345.0)
