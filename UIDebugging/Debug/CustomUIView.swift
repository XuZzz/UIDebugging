//
//  CustomUIView.swift
//  UIDebugging
//
//  Created by Xu on 2020/10/20.
//

import UIKit

open class CustomUIView: UIView {
    public var debugView: UIView? {
        didSet {
            buildUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildUI() {
        if let debugView = debugView {
            self.addSubview(debugView)
        }
    }
}
