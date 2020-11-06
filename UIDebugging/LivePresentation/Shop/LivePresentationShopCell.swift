//
//  LivePresentationShopCell.swift
//  UIDebugging
//
//  Created by Xu on 2020/11/6.
//

import UIKit

class LivePresentationShopCell: UITableViewCell {
    @IBOutlet weak var thumImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var from: UIButton!
    @IBOutlet weak var buy: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        thumImage.layer.cornerRadius = 2.5
        thumImage.backgroundColor = .app_main_buttonBackground
        title.textColor = .app_main_title
        title.font = UIFont.app_main_title.medium
        price.textColor = UIColor(hexString: "#FFC739")
        price.font = UIFont.app_main_title.medium
        
        from.backgroundColor = .app_main_buttonBackground
        from.titleLabel?.font = .systemFont(ofSize: 10)
        from.setTitleColor(.app_main_subinfo, for: .normal)
        from.setTitle("来自淘宝", for: .normal)
        from.layer.cornerRadius = 7.5
        
        
        buy.layer.cornerRadius = 2.5
        buy.layer.borderWidth = 0.5
        buy.layer.borderColor = UIColor.app_main_red.cgColor
        buy.setTitle("去抢购", for: .normal)
        buy.setTitleColor(.app_main_red, for: .normal)
        buy.titleLabel?.font = .app_main_subinfo
        
        let line = UIView(frame: .zero)
        line.backgroundColor = .app_main_buttonBackground
        contentView.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.leading.equalTo(thumImage)
            make.trailing.equalTo(buy)
            make.bottom.equalTo(contentView).offset(-0.5)
            make.height.equalTo(0.5)
        }
    }
    
}
