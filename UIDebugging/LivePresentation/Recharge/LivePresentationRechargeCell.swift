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
    @IBOutlet weak var markUp: UILabel!
    
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
    
    public var isFirst: Bool = false {
        didSet {
            markUp.isHidden = !isFirst
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectedView.backgroundColor = .app_main_background
        selectedView.layer.cornerRadius = 10
        liveNumber.textColor = .app_main_title
        chiduCoin.textColor = .app_main_content
        markUp.textColor = .app_main_red
        markUp.text = "+100%"
    }
    
    func buildUI(live: Int, coin: Int) {
        liveNumber.text = "\(live)票"
        chiduCoin.text = "\(coin).00元"
    }

}
