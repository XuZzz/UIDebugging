//
//  HomeSteerPeopleCell.swift
//  UIDebugging
//
//  Created by Xu on 2020/10/22.
//

import UIKit

class HomeSteerPeopleCell: UITableViewCell {

    private lazy var backview: UIView = {
        let v = UIView(frame: CGRect(x: 10, y: 5, width: SCREEN_WIDTH - 20, height: 80))
        v.backgroundColor = .orange
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: SCREEN_WIDTH - 20, height: 80), cornerRadius: 10)
        v.layer.cornerRadius = 10
        v.layer.shadowPath = path.cgPath
        v.layer.shadowColor = shadowColor.withAlphaComponent(0.35).cgColor
        v.layer.shadowOffset = .zero
        v.layer.shadowRadius = 5.0
        v.layer.shadowOpacity = 1.0
        return v
    }()
    
    private let shadowColor = UIColor(hexString: "#6B6B6B")
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.backgroundColor = .app_main_background
        contentView.addSubview(backview)
    }

}
