//
//  LiveListController.swift
//  UIDebugging
//
//  Created by 许朕 on 2020/11/9.
//

import UIKit

class LiveListController: UIViewController {
    
    @objc func injected() {
        self.viewDidLoad()
    }
    
    private lazy var tableView: UITableView = {
        let tableview = UITableView(frame: CGRect(x: 0,
                                                  y: 91 + 150,
                                                  width: SCREEN_WIDTH,
                                                  height: SCREEN_HEIGHT - Nav_Height - 120),
                                    style: .grouped)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.showsVerticalScrollIndicator = false
        tableview.separatorStyle = .none
        tableview.backgroundColor = .app_main_buttonBackground
        tableview.estimatedRowHeight = 270
        return tableview
    }()
    
    private var popView = RewardPopView(frame: CGRect(x: 15, y: Nav_Height + 50, width: SCREEN_WIDTH - 30, height: 44))
    
    private var popView_second = RewardPopView(frame: CGRect(x: 15, y: Nav_Height + 104, width: SCREEN_WIDTH - 30, height: 44))
    
    private var count: Int = 190 {
        didSet {
            giftStackView.giftComing(number: count)
        }
    }
    
    private var onlineUserButton = UIButton()
    
    private var giftStackView = LiveRewardStackView()
    private var giftViews: [RewardPopView] = []
    
    private var gifts: [Int] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.xz_registerCellNib(LiveListBannerCell.self)
        tableView.xz_registerCellNib(LiveListLivingCell.self)
        tableView.xz_registerCellNib(LiveListColumnCell.self)
        tableView.xz_registerCellNib(LiveListAllLivingMainCell.self)
        
        giftStackView.stackView
            .builder
            .addhere(at: view)
            .layout { (make) in
                make.top.equalTo(view).offset(101)
                make.left.equalTo(view).offset(10)
                make.right.equalTo(view).offset(-10)
                make.height.greaterThanOrEqualTo(44)
            }
            .config { (make) in
                make.backgroundColor = .blue
            }
        
        
        
        func setuoOnlineUserButton() {
            view.addSubview(onlineUserButton)
            onlineUserButton.snp.makeConstraints { (make) in
                make.right.equalTo(view).offset(-5)
                make.bottom.equalTo(view).offset(-156)
                make.size.equalTo(CGSize(width: 80, height: 20))
            }
            let attr = NSMutableAttributedString(string: "·在线用户")
            let range = NSRange(location: 0, length: attr.string.count)
            
            attr.addAttribute(.foregroundColor, value: UIColor.white, range: range)
            attr.addAttribute(.font, value: UIFont.app_main_subinfo, range: range)
            attr.addAttribute(.obliqueness, value: 0.2, range: range)
            
            onlineUserButton.setAttributedTitle(attr, for: .normal)
            
            let layer = CAShapeLayer()
            let path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 80, height: 20))
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 0, y: 20))
            path.addLine(to: CGPoint(x: 15, y: 0))
            path.addLine(to: CGPoint(x: 0, y: 0))
            path.move(to: CGPoint(x: 65, y: 20))
            path.addLine(to: CGPoint(x: 80, y: 20))
            path.addLine(to: CGPoint(x: 80, y: 0))
            path.addLine(to: CGPoint(x: 65, y: 20))
            layer.fillColor = UIColor(hexString: "#FF9600").cgColor
            
            layer.path = path.cgPath
            layer.bounds = onlineUserButton.bounds
            
            let bottom_layer = CAShapeLayer()
            let bottom_path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 80, height: 20))
            bottom_path.move(to: CGPoint(x: 0, y: 0))
            bottom_path.addLine(to: CGPoint(x: 0, y: 20))
            bottom_path.addLine(to: CGPoint(x: 15, y: 0))
            bottom_path.addLine(to: CGPoint(x: 0, y: 0))
            bottom_path.move(to: CGPoint(x: 65, y: 20))
            bottom_path.addLine(to: CGPoint(x: 80, y: 20))
            bottom_path.addLine(to: CGPoint(x: 80, y: 0))
            bottom_path.addLine(to: CGPoint(x: 65, y: 20))
            
            bottom_layer.fillColor = UIColor(hexString: "#FF9600").withAlphaComponent(0.4).cgColor
            
            bottom_layer.path = bottom_path.cgPath
            bottom_layer.bounds = CGRect(x: onlineUserButton.bounds.minX - 4,
                                         y: onlineUserButton.bounds.minY - 4,
                                         width: onlineUserButton.bounds.width,
                                         height: onlineUserButton.bounds.height)
            
            onlineUserButton.layer.addSublayer(bottom_layer)
            onlineUserButton.layer.addSublayer(layer)
        }
        
        setuoOnlineUserButton()
    }
    
    @objc private func moreAction(sender: UIButton) {
        
    }
}

extension LiveListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let cell = tableView.xz_dequeueReusableCell(LiveListBannerCell.self) {
                cell.selectionStyle = .none
                return cell
            }
        }
        if indexPath.section == 1 {
            if let cell = tableView.xz_dequeueReusableCell(LiveListLivingCell.self) {
                cell.selectionStyle = .none
                return cell
            }
        }
        
        if indexPath.section == 2 {
            if let cell = tableView.xz_dequeueReusableCell(LiveListColumnCell.self) {
                cell.selectionStyle = .none
                return cell
            }
        }
        if indexPath.section == 3 {
            if let cell = tableView.xz_dequeueReusableCell(LiveListAllLivingMainCell.self) {
                cell.selectionStyle = .none
                return cell
            }
        }
        return UITableViewCell()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 170
        }
        if indexPath.section == 1 {
            return 190
        }
        if indexPath.section == 3 {
            return 120
        }
        return 100
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerLabel = UILabel()
        let headerButton = UIButton(type: .custom)
        return UIView()
                    .builder
                    .config { [weak self](make) in
                        make.addSubview(headerLabel)
                        headerLabel.text = "掌柜朋友圈"
                        headerLabel.font = UIFont.app_main_section.medium
                        headerLabel.snp.makeConstraints { (child) in
                            child.left.equalTo(make).offset(10)
                            child.centerY.equalTo(make).offset(5)
                        }
                        
                        make.addSubview(headerButton)
                        headerButton.setTitle("查看更多", for: .normal)
                        headerButton.setTitleColor(.app_main_subinfo, for: .normal)
                        headerButton.titleLabel?.font = .app_main_subinfo
                        headerButton.contentHorizontalAlignment = .right
                        headerButton.snp.makeConstraints { (child) in
                            child.right.equalTo(make).offset(-10)
                            child.centerY.equalTo(headerLabel)
                            child.size.equalTo(CGSize(width: 70, height: 14))
                        }
                        headerButton.addTarget(self!,
                                               action: #selector(moreAction(sender:)),
                                               for: .touchUpInside)
                        
                    }.base
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.000001
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        count += 1
    }
}
