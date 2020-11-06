//
//  Spacer.swift
//  UIDebugging
//
//  Created by Xu on 2020/11/4.
//

import UIKit


class Spacer: UIView {
    
    private var height: CGFloat?
    private var width: CGFloat?
    convenience init(height: CGFloat? = nil , width: CGFloat? = nil) {
        self.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        self.height = height
        self.width = width
    }
    
    func layout() {
        self.snp.makeConstraints { (make) in
            if let height = height {
                make.height.equalTo(height)
                return
            }
            if let width = width {
                make.width.equalTo(width)
                return
            }
            make.size.equalTo(CGSize(width: 10, height: 10))
        }
    }
    
    func setColor(_ color: UIColor)-> Self {
        self.backgroundColor = color
        return self
    }
}
