 //
 //  LivePresentationController.swift
 //  UIDebugging
 //
 //  Created by Xu on 2020/11/4.
 //
 
 import UIKit
 
 class LivePresentationController: UIViewController {
    
    @objc func injected() {
        self.viewDidLoad()
    }
    
    public enum PrestentationStyle {
        case user
        case reward
        case recharge
        case shop
        case online
    }
    
    struct LivePresentationConfig {
        var userHeight: CGFloat = 245.0
        var rechargeHeight: CGFloat = 265.0
        var onlineHeight: CGFloat = 312/667 * SCREEN_HEIGHT
        var shopHeight: CGFloat = 290/667 * SCREEN_HEIGHT
        var rewardHeight: CGFloat = 308
        init() {}
    }
    
    public var style: PrestentationStyle = .user
    public var config = LivePresentationConfig()
    
    private var alertView = UIView()
    
    deinit {
        print("弹窗销毁")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.65)
        
        if style == .user {
            alertView = layoutAlertView(
                alert: LivePresentationUserView()
            )
        }
        
        if style == .recharge {
            alertView = layoutAlertView(
                alert: LivePresentationRechargeView()
            )
        }
        
        if style == .online {
            alertView = layoutAlertView(
                alert: LivePresentationOnlineView(height: config.onlineHeight)
            )
        }
        
        if style == .shop {
            alertView = LivePresentationShopView(height: config.shopHeight)
                .builder
                .addhere(at: view)
                .layout { [weak self](make) in
                    make.left.right.equalTo(view)
                    make.height.equalTo(self!.config.shopHeight)
                    make.bottom.equalTo(view).offset(500)
                }.base
        }
        
        if style == .reward {
            alertView = layoutAlertView(
                alert:
                    LivePresentationRewardView(height: config.rewardHeight)
            )
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            self.alertView.snp.updateConstraints { (make) in
                make.bottom.equalTo(self.view)
            }
            UIView.animate(withDuration: 0.2) {
                self.view.layoutIfNeeded()
            }
        }
        
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.bottom.equalTo(alertView.snp.top)
            make.left.right.top.equalTo(view)
        }
        button.addTarget(self, action: #selector(dismiss(sender:)), for: .touchUpInside)
    }
    
    func layoutAlertView(alert: UIView)-> UIView {
        let v = alert
            .builder
            .addhere(at: view)
            .layout { [weak self](make) in
                make.left.right.equalTo(view)
                if self!.style == .user {
                    make.height.equalTo(self!.config.userHeight)
                }
                if self!.style == .recharge {
                    make.height.equalTo(self!.config.rechargeHeight)
                }
                
                if self!.style == .online {
                    make.height.equalTo(self!.config.onlineHeight)
                }
                
                if self!.style == .shop {
                    make.height.equalTo(self!.config.shopHeight)
                }
                if self!.style == .reward {
                    make.height.equalTo(self!.config.rewardHeight)
                }
                
                make.bottom.equalTo(view).offset(500)
                
            }.base
        
        
        return v
    }
    
    @objc func dismiss(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
 }
 
 
 func VStackView(distribution: UIStackView.Distribution = .fill)-> UIStackView {
    let s = UIStackView()
    s.axis = .vertical
    s.distribution = distribution
    return s
 }
 
 func HStackView(distribution: UIStackView.Distribution = .fill)-> UIStackView {
    let s = UIStackView()
    s.axis = .horizontal
    s.distribution = distribution
    return s
 }
 
 extension UIStackView {
    @discardableResult
    func add(_ view: UIView, layout: ((UIView)->Void)? = nil )-> Self {
        self.addArrangedSubview(view)
        layout?(view)
        if view is Spacer, let v = view as? Spacer {
            v.layout()
        }
        return self
    }
 }
