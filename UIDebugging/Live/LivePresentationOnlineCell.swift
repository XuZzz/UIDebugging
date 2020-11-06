//
//  LivePresentationOnlineCell.swift
//  UIDebugging
//
//  Created by Xu on 2020/11/5.
//

import UIKit

class LivePresentationOnlineCell: UITableViewCell {
    @IBOutlet weak var index: UILabel!
    @IBOutlet weak var headImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var tickets: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        index.textColor = .app_main_content
        tickets.textColor = .app_main_thinRed
        userName.textColor = .app_main_title
        headImage.layer.cornerRadius = 15
        
        userName.text = "一夜暴富"
        headImage.backgroundColor = .gray
        tickets.text = "0票"
    }
    
    func buildUI() {
        
    }
    
}
