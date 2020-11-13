//
//  LiveListAllLivingCell.swift
//  UIDebugging
//
//  Created by 许朕 on 2020/11/11.
//

import UIKit

class LiveListAllLivingCell: UICollectionViewCell {
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var thumImage: UIImageView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var time: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        statusView.layer.cornerRadius = 4.0
        title.textColor = .app_main_title
        time.textColor = .app_main_subinfo
        bottomView.layer.cornerRadius = 10
        bottomView.layer.borderColor = UIColor.white.cgColor
        bottomView.layer.borderWidth = 1.5
        bottomView.backgroundColor = .white
    }
    
    override func draw(_ rect: CGRect) {
        bottomView.layer.masksToBounds = true
    }

}
