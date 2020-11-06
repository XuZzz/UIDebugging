//
//  LivePresentationRewardView.swift
//  UIDebugging
//
//  Created by Xu on 2020/11/6.
//

import UIKit

class LivePresentationRewardView: UIView {
    
    private var height: CGFloat = 0

    private lazy var bottomView: UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = .white
        return v
    }()
    
    private var hot = UIButton(type: .custom)
    private var coin = UIButton(type: .custom)
    
    private var balance = UILabel()
    private var coinNumber = UILabel()
    private var recharge = UIButton(type: .custom)
   
    convenience init(height: CGFloat) {
        self.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: height))
        self.height = height
        buildUI()
    }
    
    func buildUI() {
        bottomView
            .builder
            .addhere(at: self)
            .layout { (make) in
                make.left.right.bottom.equalTo(self)
                make.height.equalTo(height)
            }
            .config { [weak self](make) in
                make.isUserInteractionEnabled = true
                func shadowPath()-> CGPath {
                    return UIBezierPath(roundedRect: CGRect(x: 0,
                                                            y: 0,
                                                            width: bounds.width,
                                                            height: self!.height),
                                        cornerRadius: 15).cgPath
                }
                make.layer.cornerRadius = 15
                make.layer.shadowPath = shadowPath()
                make.layer.shadowColor = UIColor.setColor(hex: "#A5A5A5", alpha: 0.45).cgColor
                make.layer.shadowOpacity = 1.0
                make.layer.shadowOffset = CGSize(width: 0, height: -2)
            }
        
        VStackView()
            .builder
            .addhere(at: bottomView)
            .layout { (make) in
                make.top.bottom.equalTo(bottomView)
                make.left.equalTo(bottomView).offset(15)
                make.right.equalTo(bottomView).offset(-15)
            }
            .base
            .add(
                // MARK: 头部视图
                UIView()
                    .builder
                    .config({ (make) in
                        // MARK: 热门
                        hot
                            .builder
                            .addhere(at: make)
                            .layout { (child) in
                                child.left.equalTo(make)
                                child.centerY.equalTo(make)
                            }.config { (sub) in
                                sub.setTitle("热门", for: .normal)
                                sub.setTitleColor(.app_main_title, for: .normal)
                                sub.titleLabel?.font = UIFont.app_main_title.medium
                            }
                        // MARK: 度金
                        coin
                            .builder
                            .addhere(at: make)
                            .layout { (child) in
                                child.left.equalTo(hot.snp.right).offset(15)
                                child.centerY.equalTo(make)
                            }.config { (sub) in
                                sub.setTitle("度金", for: .normal)
                                sub.setTitleColor(.app_main_title, for: .normal)
                                sub.titleLabel?.font = UIFont.app_main_title.medium
                            }
                    })
                    .base,
                layout: { (make) in
                    make.snp.makeConstraints { (sub) in
                        sub.height.equalTo(33.5)
                    }
                }
            ).add(
                Spacer(height: 0.5)
                    .setColor(.app_main_buttonBackground)
            )
            .add(
                // MARK: 礼物列表
                UIView()
                    .builder
                    .config({ (make) in
                        make.backgroundColor = .app_main_buttonBackground
                    }).base
            )
            .add(
                // 红色虚线
                UIView()
                    .builder
                    .config({ (make) in
                        let border = { (cornerRect: CGRect)-> CAShapeLayer in
                            let border = CAShapeLayer()
                            border.strokeColor = UIColor.app_main_thinRed.cgColor
                            border.fillColor = UIColor.clear.cgColor
                            border.path = UIBezierPath(rect: cornerRect).cgPath
                            border.lineWidth = 0.5
                            border.lineDashPattern = [4,3]
                            return border
                        }
                        
                        func makeCornerBorder()-> CAShapeLayer {
                            let cornerRect = CGRect(x: 0,
                                                    y: 0,
                                                    width: SCREEN_WIDTH - 30,
                                                    height: 0.5)
                            
                            return border(cornerRect)
                        }
                        make.layer.addSublayer(makeCornerBorder())
                        
                    }).base,
                layout: { (make) in
                    make.snp.makeConstraints { (make) in
                        make.height.equalTo(0.5)
                    }
                }
            )
            .add(
                // MARK: 底部 余额度金 充值按钮
                UIView()
                    .builder
                    .config({ [weak self](make) in
                        //  MARK: 余额
                        self?.balance
                            .builder
                            .addhere(at: make)
                            .layout{ (child) in
                                child.left.equalTo(make)
                                child.centerY.equalTo(make)
                            }
                            .config({ [weak self] (make) in
                                self?.balanceConfig(number: 999)
                            })
                        //  MARK: 线
                        UIView()
                            .builder
                            .addhere(at: make)
                            .layout { [weak self](child) in
                                child.width.equalTo(1)
                                child.height.equalTo(9)
                                child.centerY.equalTo(make)
                                child.left.equalTo(self!.balance.snp.right).offset(10)
                            }
                            .config { (child) in
                                child.backgroundColor = .app_main_title
                            }
                        // MARK: 度金
                        self?.coinNumber
                            .builder
                            .addhere(at: make)
                            .layout{ [weak self](child) in
                                child.left.equalTo(self!.balance.snp.right).offset(21)
                                child.centerY.equalTo(make)
                            }
                            .config({ [weak self] (child) in
                                self?.coinNumberConfig(number: 2333)
                            })
                        // MARK: 充值按钮
                        self?.recharge
                            .builder
                            .addhere(at: make)
                            .layout{(child) in
                                child.right.equalTo(make)
                                child.centerY.equalTo(make)
                                child.size.equalTo(CGSize(width: 110, height: 33.5))
                            }
                            .config({ [weak self] (child) in
                                child.contentHorizontalAlignment = .right
                                self?.rechargeButtonConfig()
                            })
                    })
                    .base
                , layout: { (make) in
                    make.snp.makeConstraints { (make) in
                        make.height.equalTo(33.5)
                    }
                }
            )
            .add(Spacer(height: 20))
    }
    
    private func balanceConfig(number: Int) {
        let attr = NSMutableAttributedString(string: "余额: ")
        let range = NSRange(location: 0, length: attr.string.count)
        attr.addAttribute(.foregroundColor,
                          value: UIColor.app_main_title,
                          range: range)
        attr.addAttribute(.font,
                          value: UIFont.app_main_content,
                          range: range)
        
        let b_attr = NSMutableAttributedString(string: "\(number)票")
        let b_range = NSRange(location: 0, length: b_attr.string.count - 1)
        b_attr.addAttribute(.foregroundColor,
                          value: UIColor.app_main_title,
                          range: NSRange(location: 0, length: b_attr.string.count))
        b_attr.addAttribute(.font,
                          value: UIFont.app_main_content,
                          range: NSRange(location: 0, length: b_attr.string.count))
        b_attr.addAttribute(.foregroundColor,
                          value: UIColor.app_main_thinRed,
                          range: b_range)
        attr.append(b_attr)
        balance.attributedText = attr
    }
    
    private func coinNumberConfig(number: Int) {
        let attr = NSMutableAttributedString(string: "度金: ")
        let range = NSRange(location: 0, length: attr.string.count)
        attr.addAttribute(.foregroundColor,
                          value: UIColor.app_main_title,
                          range: range)
        attr.addAttribute(.font,
                          value: UIFont.app_main_content,
                          range: range)
        
        let b_attr = NSMutableAttributedString(string: "\(number)")
        let b_range = NSRange(location: 0, length: b_attr.string.count)
        b_attr.addAttribute(.font,
                          value: UIFont.app_main_content,
                          range: b_range)
        b_attr.addAttribute(.foregroundColor,
                          value: UIColor.app_main_thinRed,
                          range: b_range)
        attr.append(b_attr)
        coinNumber.attributedText = attr
    }
    
    private func rechargeButtonConfig() {
        let attr = NSMutableAttributedString(string: "首充有礼: ")
        let range = NSRange(location: 0, length: attr.string.count)
        attr.addAttribute(.foregroundColor,
                          value: UIColor.app_main_title,
                          range: range)
        attr.addAttribute(.font,
                          value: UIFont.app_main_content,
                          range: range)
        
        let r_attr = NSMutableAttributedString(string: "充值")
        let r_range = NSRange(location: 0, length: r_attr.string.count)
        r_attr.addAttribute(.foregroundColor,
                          value: UIColor(hexString: "#FFC739"),
                          range: r_range)
        r_attr.addAttribute(.font,
                            value: UIFont.app_main_content.medium,
                          range: r_range)
        attr.append(r_attr)
        recharge.setAttributedTitle(attr, for: .normal)
    }

}
