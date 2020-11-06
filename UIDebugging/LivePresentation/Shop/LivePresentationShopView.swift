//
//  LivePresentationShopView.swift
//  UIDebugging
//
//  Created by Xu on 2020/11/6.
//

import UIKit

class LivePresentationShopView: UIView {
    
    @objc func injected() {
        buildUI()
    }
    
    private var height: CGFloat = 0

    private lazy var bottomView: UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = .white
        return v
    }()
    
    private var titleLabel = UILabel(frame: .zero)
    
    private lazy var tableView: UITableView = {
        let tableview = UITableView(frame: .zero,
                                    style: .plain)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.showsVerticalScrollIndicator = false
        tableview.separatorStyle = .none
        tableview.xz_registerCellNib(LivePresentationShopCell.self)
        return tableview
    }()
    
    convenience init(height: CGFloat) {
        self.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: height))
        self.height = height
        buildUI()
    }
    
    private func buildUI() {
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
                titleLabel
                    .builder
                    .config({ [weak self] (make) in
                        self?.titleLabelConfig(commodityNumber: 35)
                    })
                    .base) { (make) in
                make.snp.makeConstraints {(child) in
                    child.height.equalTo(33.5)
                }
            }
            .add(
                Spacer(height: 0.5)
                    .setColor(UIColor(hexString: "#EEEEEE"))
            )
            .add(
                tableView
            )
            .add(Spacer(height: 20))
    }
    
    private func titleLabelConfig(commodityNumber: Int) {
        let attr = NSMutableAttributedString(string: "商品 ")
        let commodity = NSMutableAttributedString(string: "共\(commodityNumber)件商品")
        
        let attrRange = NSRange(location: 0, length: attr.string.count)
        attr.addAttribute(.foregroundColor,
                          value: UIColor.app_main_title,
                          range: attrRange)
        attr.addAttribute(.font,
                          value: UIFont.app_main_title.medium,
                          range: attrRange)
        
        let commodityRange = NSRange(location: 0,
                                     length: commodity.string.count)
        commodity.addAttribute(.foregroundColor,
                               value: UIColor.app_main_content,
                               range: commodityRange)
        commodity.addAttribute(.font,
                               value: UIFont.app_main_subinfo,
                               range: commodityRange)
        
        let commodityNumberRange = NSRange(location: 1, length: "\(commodityNumber)".count)
        commodity.addAttribute(.foregroundColor,
                               value: UIColor(hexString: "#FFC739"),
                               range: commodityNumberRange)
        
        attr.append(commodity)
        titleLabel.attributedText = attr
    }
}

extension LivePresentationShopView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.xz_dequeueReusableCell(LivePresentationShopCell.self) {
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
