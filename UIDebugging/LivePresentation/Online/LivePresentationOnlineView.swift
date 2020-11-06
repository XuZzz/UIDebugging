//
//  LivePresentationOnlineView.swift
//  UIDebugging
//
//  Created by Xu on 2020/11/5.
//

import UIKit

class LivePresentationOnlineView: UIView {
    
    private lazy var bottomView: UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = .white
        return v
    }()
    
    private lazy var tableView: UITableView = {
        let tableview = UITableView(frame: .zero,
                                    style: .plain)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.showsVerticalScrollIndicator = false
        tableview.separatorStyle = .none
        tableview.rowHeight = 50
        tableview.xz_registerCellNib(LivePresentationOnlineCell.self)
        return tableview
    }()
    
    private var height: CGFloat = 0.0
    
    private var allTicket = UILabel()
    
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
                make.left.equalTo(bottomView).offset(10)
                make.right.equalTo(bottomView).offset(-10)
            }
            .base
            .add(
                UIView()
                    .builder
                    .config({ (make) in
                        UILabel()
                            .builder
                            .addhere(at: make)
                            .layout { (sub) in
                                sub.left.equalTo(make).offset(5)
                                sub.centerY.equalTo(make)
                            }
                            .config { (sub) in
                                sub.text = "在线用户"
                                sub.textAlignment = .left
                                sub.textColor = .app_main_title
                                sub.font = .app_main_title
                            }
                        
                        allTicket
                            .builder
                            .addhere(at: make)
                            .layout { (sub) in
                                sub.right.equalTo(make).offset(-5)
                                sub.centerY.equalTo(make)
                            }
                            .config { [weak self](sub) in
                                sub.font = .app_main_content
                                sub.textColor = .app_main_title
                                sub.attributedText = self?.allticketConfig(390730)
                            }
                        
                    })
                    .base
                ,layout: { (make) in
                    make.snp.makeConstraints { (make) in
                        make.height.equalTo(33.5)
                    }
                }
            )
            .add(Spacer(height: 0.5)
                    .setColor(UIColor(hexString: "#EEEEEE")))
            .add(
                tableView
            )
            .add(
                UILabel()
                    .builder
                    .config({ (make) in
                        make.text = "仅展示打赏榜前10名用户"
                        make.textAlignment = .center
                        make.textColor = .app_main_subinfo
                        make.font = .app_main_subinfo
                    })
                    .base
            ) { (make) in
                make.snp.makeConstraints { (make) in
                    make.height.equalTo(32)
                }
            }
            .add(Spacer(height: 20))
        
    }
    
    
    private func allticketConfig(_ ticket: Int)-> NSAttributedString {
        let attr = NSMutableAttributedString(string: "总票数: ")
        let tic = NSMutableAttributedString(string: "\(ticket)")
        
        tic.addAttribute(.foregroundColor,
                         value: UIColor.app_main_thinRed,
                         range: NSRange(location: 0, length: String(ticket).count))
        attr.append(tic)
        return attr
    }
    
    
}

extension LivePresentationOnlineView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.xz_dequeueReusableCell(LivePresentationOnlineCell.self) {
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
}

