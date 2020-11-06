//
//  LivePresentationRechargeCell.swift
//  UIDebugging
//
//  Created by Xu on 2020/11/5.
//

import UIKit

class LivePresentationRechargeCell: UICollectionViewCell {
    @IBOutlet weak var liveNumber: UILabel!
    @IBOutlet weak var chiduCoin: UILabel!
    @IBOutlet weak var selectedView: UIView!
    
    var itemSelected: Bool = false {
        didSet {
            if itemSelected {
                selectedView.layer.borderColor = UIColor.app_main_title.cgColor
                selectedView.layer.borderWidth = 1.0
            }else {
                selectedView.layer.borderColor = UIColor.clear.cgColor
                selectedView.layer.borderWidth = 1.0
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectedView.backgroundColor = .app_main_background
        selectedView.layer.cornerRadius = 10
        liveNumber.textColor = .app_main_title
        chiduCoin.textColor = .app_main_content
    }
    
    func buildUI(live: Int, coin: Int) {
        liveNumber.text = "\(live)票"
        chiduCoin.text = "\(coin).00元"
    }

}
