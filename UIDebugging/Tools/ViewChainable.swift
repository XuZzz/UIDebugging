//
//  ViewChainable.swift
//  delinshe_ios
//
//  Created by Xu on 2020/9/14.
//  Copyright © 2020 com.delinshe. All rights reserved.
//

import Foundation
import SnapKit


protocol ViewChainNameSpace {
    associatedtype NamespaceType
    var builder: NamespaceType {get}
    static var chain: NamespaceType.Type {get}
}

extension ViewChainNameSpace {
    var builder: ViewChainWrapper<Self> {
        return ViewChainWrapper(self)
    }
    
    static var chain: ViewChainWrapper<Self>.Type {
        return ViewChainWrapper.self
    }
}

public struct ViewChainWrapper<Base> {
    public var base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

extension UIView: ViewChainNameSpace {}

extension ViewChainWrapper where Base: UIView {
    @discardableResult
    func addhere(at superview: UIView)-> Self {
        superview.addSubview(base)
        return base.builder
    }
    
    @discardableResult
    func layout(snapKitMaker: (ConstraintMaker)-> Void)-> Self {
        base.snp.makeConstraints(snapKitMaker)
        return base.builder
    }
    
    @discardableResult
    func config(_ config: ((Base)-> Void))-> Self {
        config(base)
        return base.builder
    }
}

