//
//  LivePresentationUserView.swift
//  UIDebugging
//
//  Created by Xu on 2020/11/5.
//

import UIKit

class LivePresentationUserView: UIView {
    open var height: CGFloat {245}
    
    private lazy var headImage: UIImageView = {
        let h = UIImageView(frame: .zero)
        h.contentMode = .scaleAspectFill
        return h
    }()
    
    private lazy var bottomView: UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = .white
        return v
    }()
    
    private lazy var verticalStackview: UIStackView = {
        let s = UIStackView()
        s.axis = .vertical
        s.distribution = .fill
        return s
    }()
    
    
    private var userName = UILabel()
    private var introduce = UILabel()
    private var attend = UIButton(type: .custom)
    
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 245))
        buildUI()
    }
    
    private func buildUI() {
        bottomView
            .builder
            .addhere(at: self)
            .layout { (make) in
                make.left.right.bottom.equalTo(self)
                make.height.equalTo(210)
            }
            .config { (make) in
                make.isUserInteractionEnabled = true
                func shadowPath()-> CGPath {
                    return UIBezierPath(roundedRect: CGRect(x: 0,
                                                            y: 0,
                                                            width: bounds.width,
                                                            height: 210),
                                        cornerRadius: 15).cgPath
                }
                make.layer.cornerRadius = 15
                make.layer.shadowPath = shadowPath()
                make.layer.shadowColor = UIColor.setColor(hex: "#A5A5A5", alpha: 0.45).cgColor
                make.layer.shadowOpacity = 1.0
                make.layer.shadowOffset = CGSize(width: 0, height: -2)
            }
        
        headImage
            .builder
            .addhere(at: self)
            .layout { (make) in
                make.centerX.equalTo(self)
                make.top.equalTo(self)
                make.size.equalTo(CGSize(width: 70, height: 70))
            }.config { (make) in
                make.layer.cornerRadius = 35
                make.layer.borderWidth = 1.0
                make.layer.borderColor = UIColor.app_main_red.cgColor
                make.backgroundColor = .white
            }
        
        VStackView(distribution: .fill)
            .builder
            .addhere(at: bottomView)
            .layout { (make) in
                make.top.equalTo(35)
                make.left.right.bottom.equalTo(bottomView)
            }.config { [weak self](make) in
                self?.verticalStackviewConfig(stack: make)
            }
    }
    
    private func verticalStackviewConfig(stack: UIStackView) {
        
        stack
            .add(Spacer(height: 10))
            .add(
                userName
                    .builder
                    .config { (make) in
                        make.textAlignment = .center
                        make.textColor = .app_main_title
                        make.font = UIFont.app_main_section.medium
                        make.text = "一夜暴富"
                    }.base
            )
            .add(Spacer(height: 8))
            .add(
                introduce
                    .builder
                    .config { (make) in
                        make.textAlignment = .center
                        make.textColor = .app_main_subinfo
                        make.font = UIFont.app_main_content
                        make.text = "个人简介：我是贵州茅台董事长"
                        make.numberOfLines = 1
                    }
                    .base
            )
            .add(Spacer(height: 10))
            .add(
                HStackView(distribution: .fillEqually)
                    .add(
                        setupHorizontalButtons(top: "666票",
                                               bottom: "打赏金额")
                        , layout: { (make) in
                            self.horizontalButtonLayout(make: make)
                        }
                    )
                    .add(
                        setupHorizontalButtons(top: "2333w",
                                               bottom: "粉丝数")
                        , layout: { (make) in
                            make.snp.makeConstraints { (make) in
                                make.height.equalTo(54)
                            }
                        }
                    )
                    .add(
                        setupHorizontalButtons(top: "100",
                                               bottom: "关注数")
                        , layout: { (make) in
                            make.snp.makeConstraints { (make) in
                                make.height.equalTo(54)
                            }
                        }
                    )
            )
            .add(
                HStackView()
                    .add(Spacer(width: 68))
                    .add(
                        attend
                            .builder
                            .config { (make) in
                                make.backgroundColor = .app_main_red
                                make.layer.cornerRadius = 10
                                make.setTitle("关注", for: .normal)
                                make.setTitleColor(.white, for: .normal)
                                make.titleLabel?.font = UIFont.app_main_big.medium
                            }.base
                    )
                    .add(Spacer(width: 68))
            )
            .add(Spacer(height: 15))
        
        attend.snp.makeConstraints { (make) in
            make.height.equalTo(44)
        }
    }
    
    func setupHorizontalButtons(top: String, bottom: String)-> HorizontalTextButton{
        let make = HorizontalTextButton()
        make.topTitle = top
        make.bottomTitle = bottom
        make.topFont = UIFont.app_main_content.medium
        make.bottomFont = UIFont.app_main_content
        make.topColor = .app_main_title
        make.bottomColor = .app_main_subinfo
        make.lines = 3
        make.setText()
        return make
    }
    
    func horizontalButtonLayout(make: UIView) {
        make.snp.makeConstraints { (make) in
            make.height.equalTo(54)
        }
    }
}
