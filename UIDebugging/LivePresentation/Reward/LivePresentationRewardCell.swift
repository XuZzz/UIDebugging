//
//  LivePresentationRewardCell.swift
//  UIDebugging
//
//  Created by 许朕 on 2020/11/9.
//

import UIKit

class LivePresentationRewardCell: UICollectionViewCell {
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var thumImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var number: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bottomView.layer.cornerRadius = 20
        thumImage.layer.cornerRadius = 25
        name.textColor = .app_main_title
        number.textColor = .app_main_thinRed
    }
    
    func buildUI(gift: String, cost: String) {
        name.text = gift
        number.text = cost
    }

}
