//
//  LivePresentationRechargeView.swift
//  UIDebugging
//
//  Created by Xu on 2020/11/5.
//

import Foundation

class LivePresentationRechargeView: UIView, UITextViewDelegate {
    
    public var isFirstRecharge: Bool = true

    private var titleLabel = UITextView()
    private var balance = UILabel()
    private var rechargeButton = UIButton(type: .custom)
    private lazy var rechargeAreaview: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        // 列间距
        layout.minimumLineSpacing = 10
        // item之间的间距
        layout.minimumInteritemSpacing = 8
        let collect = UICollectionView(frame: .zero,
                                       collectionViewLayout: layout)
        collect.showsVerticalScrollIndicator = false
        collect.showsHorizontalScrollIndicator = false
        collect.delegate = self
        collect.dataSource = self
        collect.bounces = true
        collect.isScrollEnabled = false
        collect.backgroundColor = .white
        collect.layer.cornerRadius = 10
        collect.register(UINib(nibName: "LivePresentationRechargeCell",
                               bundle: nil),
                         forCellWithReuseIdentifier: "LivePresentationRechargeCell")
        return collect
    }()
    
    private lazy var bottomView: UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = .white
        return v
    }()
    
    private var contents: [(live: Int, coin: Int, id: Int, isSelected: Bool)]?
    
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 265))
        
        contents = [(70, 1),(420, 6),(2100, 30),(6860, 98),(200860, 298),(36260, 518)].map({ (item) -> (Int, Int, Int, Bool) in
            let live = item.0
            let coin = item.1
            var selected = false
            if coin == 6 {selected = true}
            return (live, coin, live, selected)
        })
            
        buildUI()
    }
    
    private func buildUI() {
        bottomView
            .builder
            .addhere(at: self)
            .layout { (make) in
                make.left.right.bottom.equalTo(self)
                make.height.equalTo(265)
            }
            .config { (make) in
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
        
        VStackView()
            .builder
            .addhere(at: bottomView)
            .layout { (make) in
                make.top.bottom.equalTo(bottomView)
                make.left.equalTo(bottomView).offset(10)
                make.right.equalTo(bottomView).offset(-10)
            }
            .base
            .add(
                // TitleLabel
                titleLabel
                    .builder
                    .config({ [weak self](make) in
                        make.isEditable = false
                        make.isScrollEnabled = false
                        make.isSelectable = true
                        make.attributedText = self?.titleLabelConfig()
                        make.linkTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor(hexString: "#FFC739")]
                        make.delegate = self!
                    })
                    .base) { (make) in
                make.snp.makeConstraints { (make) in
                    make.top.equalTo(1)
                    make.height.equalTo(33.5)
                }
            }
            .add(
                // 分割线
                Spacer(height: 0.5)
                    .setColor(UIColor(hexString: "#EEEEEE"))
            )
            .add(Spacer(height: 10))
            .add(
                // 充值区域
                rechargeAreaview
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
                                                    width: SCREEN_WIDTH - 20,
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
            .add(Spacer(height: 8))
            .add(
                // 底部 余额 充值按钮
                UIView()
                    .builder
                    .config({ (make) in
                        balance
                            .builder
                            .addhere(at: make)
                            .layout { (sub) in
                                sub.centerY.equalTo(make)
                                sub.leading.equalTo(make).offset(5)
                            }.config { [weak self](sub) in
                                self?.balanceConfig()
                            }
                        rechargeButton
                            .builder
                            .addhere(at: make)
                            .layout { (sub) in
                                sub.right.equalTo(make).offset(-5)
                                sub.centerY.equalTo(make)
                                sub.width.greaterThanOrEqualTo(96)
                                sub.height.equalTo(22)
                            }
                            .config { [weak self](sub) in
                                sub.layer.cornerRadius = 11
                                sub.backgroundColor = .app_main_thinRed
                                sub.setTitleColor(.white, for: .normal)
                                sub.titleLabel?.font = UIFont.app_main_subinfo.medium
                                sub.addTarget(self!, action: #selector(rechargeAction(sender:)), for: .touchUpInside)
                                if let contents = self!.contents {
                                    for item in contents {
                                        if item.isSelected {
                                            self?.rechargeButtonConfig(number: item.coin)
                                            break
                                        }
                                    }
                                }
                            }
                    })
                    .base
                , layout: { (make) in
                    make.snp.makeConstraints { (make) in
                        make.height.equalTo(22)
                    }
                }
            )
            .add(Spacer(height: 20))
    }
    
    @objc private func rechargeAction(sender: UIButton) {
        print("充值开始")
        rechargeButtonConfig(number: 6)
    }
    
    private func balanceConfig() {
        let pre = NSMutableAttributedString(string: "余额: ")
        let number = NSMutableAttributedString(string: "999")
        let suf = NSMutableAttributedString(string: "票")
        
        pre.addAttribute(.foregroundColor, value: UIColor.app_main_title, range: NSRange(location: 0, length: pre.string.count))
        suf.addAttribute(.foregroundColor, value: UIColor.app_main_title, range: NSRange(location: 0, length: suf.string.count))
        
        number.addAttribute(.foregroundColor,
                            value: UIColor.app_main_thinRed,
                            range: NSRange(location: 0, length: number.string.count))
        
        pre.append(number)
        pre.append(suf)
        
        pre.addAttribute(.font, value: UIFont.app_main_content, range: NSRange(location: 0, length: pre.string.count))
        
        balance.attributedText = pre
    }
    
    private func rechargeButtonConfig(number: Int) {
        rechargeButton.setTitle("确认支付\(number)元", for: .normal)
    }
    
    private func titleLabelConfig()-> NSAttributedString {
        let recharge = NSMutableAttributedString(string: "充值")
        let firstRecharge = isFirstRecharge ? NSMutableAttributedString(string: "(首充奖励)") : NSMutableAttributedString(string: "")
        let deal = NSMutableAttributedString(string: " 充值即代表同意")
        let dealUrl = NSMutableAttributedString(string: "用户充值协议")
        
        let rechargeRange = NSRange(location: 0, length: recharge.string.count)
        recharge.addAttribute(.foregroundColor,
                              value: UIColor.app_main_title,
                              range: rechargeRange)
        recharge.addAttribute(.font,
                              value: UIFont.app_main_title.medium,
                              range: rechargeRange)
        
        let firstRechargeRange = NSRange(location: 0, length: firstRecharge.string.count)
        firstRecharge.addAttribute(.foregroundColor,
                                   value: UIColor.app_main_red,
                                   range: firstRechargeRange)
        firstRecharge.addAttribute(.font,
                              value: UIFont.app_main_subinfo,
                              range: firstRechargeRange)
        
        let dealRange = NSRange(location: 0, length: deal.string.count)
        deal.addAttribute(.foregroundColor,
                          value: UIColor.app_main_content,
                          range: dealRange)
        deal.addAttribute(.font,
                              value: UIFont.app_main_subinfo,
                              range: dealRange)
        
        let dealUrlRange = NSRange(location: 0, length: dealUrl.string.count)
        dealUrl.addAttribute(.link, value: "dealUrl://", range: dealUrlRange)
        dealUrl.addAttribute(.font, value: UIFont.app_main_subinfo, range: dealUrlRange)
        
        
        recharge.append(firstRecharge)
        recharge.append(deal)
        recharge.append(dealUrl)
        return recharge
    }
    
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        let scheme = URL.absoluteString
        let urlCode = String(scheme.split(separator: ":").first ?? "")
        if urlCode == "dealUrl" {
            print("用户协议")
            return false
        }
        
        return true
    }
}

extension LivePresentationRechargeView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LivePresentationRechargeCell",
                                                      for: indexPath) as! LivePresentationRechargeCell
        if let contents = contents, let content = contents[safe: indexPath.item] {
            cell.itemSelected = content.isSelected
            cell.isFirst = isFirstRecharge
            cell.buildUI(live: content.live, coin: content.coin)
        }
        return cell
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let contents = contents {return contents.count}
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (SCREEN_WIDTH - 20 - 16) / 3, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let c = contents, let content = c[safe: indexPath.item] {
            contents = c.map({ (item) -> (Int, Int, Int, Bool) in
                var newItem = item
                if content.id == item.id {
                    newItem.isSelected = true
                    rechargeButtonConfig(number: newItem.coin)
                }else {
                    newItem.isSelected = false
                }
                return newItem
            })
            rechargeAreaview.reloadData()
        }
    }

}
