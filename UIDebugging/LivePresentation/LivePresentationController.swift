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
        var rewardHeight: CGFloat = 290/667 * SCREEN_HEIGHT
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
         view.backgroundColor = .setColor(hex: "#333333",
                                          alpha: 0.65)
         
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
            alertView = layoutAlertView(
                alert:
                    LivePresentationShopView(height: config.shopHeight)
            )
        }
        
        if style == .reward {
            alertView = layoutAlertView(
                alert:
                    LivePresentationRewardView(height: config.shopHeight)
            )
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
                 make.bottom.left.right.equalTo(view)
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
                 
             }.base
         return v
     }
     
     @objc func dismiss(sender: UIButton) {
         self.dismiss(animated: true, completion: nil)
     }
    
    
//        alertView.transform = .init(scaleX: 0.000001, y: 0.0000001)
//        alertView.isUserInteractionEnabled = true
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//            UIView.animate(withDuration: 0.15, delay: 0.1,
//                           usingSpringWithDamping: 0.9,
//                           initialSpringVelocity: 15.0,
//                           options: .curveLinear,
//                           animations: {
//                            self.alertView.transform = .identity
//            }) { (done) in
//
//            }
//        }
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
