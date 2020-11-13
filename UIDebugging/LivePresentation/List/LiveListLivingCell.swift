//
//  LiveListLivingCell.swift
//  UIDebugging
//
//  Created by 许朕 on 2020/11/9.
//

import UIKit

class LiveListLivingCell: UITableViewCell {
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var thumImage: UIImageView!
    @IBOutlet weak var point: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var introduce: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.backgroundColor = .app_main_buttonBackground
        bottomView.layer.cornerRadius = 10
        bottomView.layer.borderWidth = 1.5
        bottomView.layer.borderColor = UIColor.white.cgColor
        bottomView.layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0,
                                                                       y: 0,
                                                                       width: SCREEN_WIDTH - 20,
                                                                       height: 170),
                                                   cornerRadius: 10).cgPath
        bottomView.layer.shadowColor = UIColor.lightGray.cgColor
        bottomView.layer.shadowOffset = .zero
        bottomView.layer.shadowRadius = 5.0
        bottomView.layer.shadowOpacity = 1.0
        
        thumImage.backgroundColor = .app_main_buttonBackground
        thumImage.corner(byRoundingCorners: [.topLeft, .topRight], radii: 10)
        
        
        point.layer.cornerRadius = 4
        point.backgroundColor = .app_main_thinRed
        title.textColor = .app_main_thinRed
        introduce.text = "20:20 散户如何干饭基金经理"
        introduce.textColor = .app_main_content
    }
    
}
