//
//  LiveListBannerCell.swift
//  UIDebugging
//
//  Created by 许朕 on 2020/11/9.
//

import UIKit

class LiveListBannerCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.backgroundColor = .app_main_buttonBackground
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
