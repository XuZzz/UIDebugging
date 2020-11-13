//
//  LiveListColumnCell.swift
//  UIDebugging
//
//  Created by 许朕 on 2020/11/9.
//

import UIKit

class LiveListColumnCell: UITableViewCell {
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var thumImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var introduce: UILabel!
    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var status: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.backgroundColor = .app_main_buttonBackground
        thumImage.backgroundColor = .app_main_buttonBackground
        
        title.textColor = .app_main_red
        introduce.textColor = .app_main_subinfo
        time.textColor = .app_main_subinfo
        cost.textColor = UIColor(hexString: "#FFC739")
        
        title.font = .app_main_subinfo
        introduce.font = .app_main_subinfo
        cost.font = .app_main_subinfo
        
    }
    override func draw(_ rect: CGRect) {
        bottomView.corner(byRoundingCorners: [.topRight, .bottomRight], radii: 10)
    }
}
