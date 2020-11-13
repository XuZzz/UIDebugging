//
//  RewardPopView.swift
//  UIDebugging
//
//  Created by 许朕 on 2020/11/12.
//

import Foundation

class RewardPopView: UIView {
    
    var animationComplete: (()-> Void)?
    
    public var isAnimating: Bool = false
    
    private var shadowView = UIView()
    private var bottomView = UIView()
    private var headImageView = UIImageView()
    private var userName = UILabel()
    private var subinfo = UILabel()
    private var thumImageView = UIImageView()
    private var giftCount = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isHidden = true
        self.transform = CGAffineTransform(translationX: -SCREEN_WIDTH, y: 0)
        buildUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        shadowView.layer.cornerRadius = 22
        shadowView.layer
            .shadowPath = UIBezierPath(
                roundedRect: CGRect(x: 0, y: 0, width: 165, height: 44),
                cornerRadius: 22)
            .cgPath
        shadowView.layer.shadowColor = UIColor(hexString: "#FF883F").cgColor
        shadowView.layer.shadowOpacity = 0.7
        shadowView.layer.shadowRadius = 4.0
        shadowView.layer.shadowOffset = .zero
        
        let colors = [
            UIColor(hexString: "#F9AD50"),
            UIColor(hexString: "#FFFFFF"),
            UIColor(hexString: "#FFFFFF")
        ]
        let locations = [
            NSNumber(value: 0),
            NSNumber(value: 0.75),
            NSNumber(value: 1.0)
        ]
        bottomView.setBackgroundGradientColor(colors: colors,
                                        startPoint: CGPoint(x: 0, y: 0),
                                        endPoint: CGPoint(x: 1, y: 1),
                                        locations: locations,
                                        cornerRadius: 22)
    }
    
    func newGiftComing(user: String, number: Int, type: String) {
        userName.text = user
        giftCountConfig(number: number)
        subinfoConfig(type: type)
        show()
    }
    
    func show() {
        isAnimating = true
        isHidden = false
        
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut) {
            self.transform = .identity
        } completion: { (done) in
            if done {
                UIView.animate(withDuration: 1.0, delay: 3.0, options: .curveEaseInOut) {
                    self.transform = CGAffineTransform(translationX: -SCREEN_WIDTH, y: 0)
                } completion: { (done) in
                    if done {
                        self.isHidden = true
                        self.isAnimating = false
                        self.animationComplete?()
                    }
                }
            }
        }
    }
    
    private func buildUI() {
        shadowView
            .builder
            .addhere(at: self)
            .layout { (make) in
                make.top.bottom.left.equalTo(self)
                make.width.equalTo(165)
            }.config { (make) in
                make.backgroundColor = .white
            }
        bottomView
            .builder
            .addhere(at: shadowView)
            .layout { (make) in
                make.edges.equalTo(shadowView)
            }
            .config { [weak self](make) in
                self?.bottomViewConfig(view: make)
            }
        
        giftCount
            .builder
            .addhere(at: self)
            .layout { (make) in
                make.left.equalTo(bottomView.snp.right).offset(6)
                make.top.bottom.equalTo(bottomView)
                make.right.equalTo(self)
            }
            .config { [weak self](make) in
                make.textAlignment = .left
                self?.giftCountConfig(number: 329)
            }
    }
    
    
    private func giftCountConfig(number: Int) {
        let attr = NSMutableAttributedString(string: "x\(number)")
        let range = NSRange(location: 0, length: attr.string.count)
        attr.addAttribute(.font, value: UIFont.systemFont(ofSize: 24, weight: .medium), range: range)
        attr.addAttribute(.strokeColor, value: UIColor(hexString: "#995D1C"), range: range)
        attr.addAttribute(.strokeWidth, value: -1.0, range: range)
        attr.addAttribute(.foregroundColor, value: UIColor(hexString: "#FF9600"), range: range)
        attr.addAttribute(.obliqueness, value: 0.2, range: range)
        giftCount.attributedText = attr
    }
    
    private func subinfoConfig(type: String) {
        let attr = NSMutableAttributedString(string: "送出了")
        attr.addAttribute(.foregroundColor, value: UIColor.app_main_content, range: NSRange(location: 0, length: attr.string.count))
        attr.addAttribute(.font, value: UIFont.app_main_subinfo, range: NSRange(location: 0, length: attr.string.count))
        let type_attr = NSMutableAttributedString(string: type)
        type_attr.addAttribute(.foregroundColor, value: UIColor.app_main_red, range: NSRange(location: 0, length: type_attr.string.count))
        attr.append(type_attr)
        subinfo.attributedText = attr
    }
    
    private func bottomViewConfig(view: UIView) {
        headImageView
            .builder
            .addhere(at: view)
            .layout { (make) in
                make.left.equalTo(view).offset(5)
                make.centerY.equalTo(view)
                make.size.equalTo(CGSize(width: 34, height: 34))
            }.config { (make) in
                make.layer.cornerRadius = 17
                make.backgroundColor = UIColor(hexString: "#E5E5E5")
            }
        
        thumImageView
            .builder
            .addhere(at: view)
            .layout { (make) in
                make.right.equalTo(view.snp.right).offset(-5)
                make.bottom.equalTo(headImageView.snp.bottom)
                make.size.equalTo(CGSize(width: 41, height: 44))
            }
            .config { (make) in
                make.backgroundColor = .yellow
                make.contentMode = .scaleAspectFill
            }
        
        userName
            .builder
            .addhere(at: view)
            .layout { (make) in
                make.left.equalTo(headImageView.snp.right).offset(8)
                make.right.equalTo(thumImageView.snp.left).offset(8)
                make.top.equalTo(headImageView).offset(1)
            }
            .config { (make) in
                make.text = "用户昵称"
                make.textColor = .app_main_title
                make.font = UIFont.app_main_content.medium
                make.textAlignment = .left
                make.numberOfLines = 1
            }
        subinfo
            .builder
            .addhere(at: view)
            .layout { (make) in
                make.left.equalTo(headImageView.snp.right).offset(8)
                make.right.equalTo(userName.snp.right)
                make.bottom.equalTo(headImageView).offset(-1)
            }
            .config { (make) in
                make.textColor = .app_main_content
                make.font = UIFont.app_main_subinfo
                make.textAlignment = .left
                make.numberOfLines = 1
            }
        
    }
}
