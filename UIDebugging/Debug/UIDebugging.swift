//
//  UIDebugging.swift
//  UIDebugging
//
//  Created by Xu on 2020/10/20.
//

import SwiftUI

var SCREEN_WIDTH: CGFloat {UIScreen.main.bounds.width}
var SCREEN_HEIGHT: CGFloat {UIScreen.main.bounds.height}

protocol UIDebugLoadNibAble: UIView {}

extension UIDebugLoadNibAble {
    static func loadFromNib()-> Self? {
        return Bundle.main.loadNibNamed("\(self)", owner: nil, options: nil)?.first as? Self
    }
}

protocol UIDebugable: UIView {
    var debugPosition: (x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {get set}
    func makeUIDebug()-> UIView
}


extension UIDebugable where Self : UIDebugLoadNibAble {
    
    var debugPosition: (x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        get {
            (self.frame.origin.x,
             self.frame.origin.y,
             self.frame.size.width,
             self.frame.size.height)
        }
        set {
            self.frame = CGRect(x: newValue.x,
                                y: newValue.y,
                                width: newValue.width,
                                height: newValue.height)
        }
    }
    
    func makeUIDebug()-> UIView {
        
        if let v = Self.loadFromNib() {
            return v
        }
        
        let v = Self.init(frame: .zero)
        return v
    }
}

extension UIView: UIDebugable, UIDebugLoadNibAble {}

@available(iOS 13.0, *)
struct CustomView: UIViewRepresentable {
    
    @Binding var text: String
    func makeUIView(context: Context) -> CustomUIView {
        let view = CustomUIView()
        let label = CompanyProfitRankView(stock: "贵州茅台")
        label.backgroundColor = .white
        label.debugPosition = (0, 30 ,label.bounds.width,  label.bounds.height)
        
        view.debugView = label
        return view
    }
    
    func updateUIView(_ uiView: CustomUIView, context: Context) {
    }
}

