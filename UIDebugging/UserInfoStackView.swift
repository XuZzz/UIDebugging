//
//  UserInfoStackView.swift
//  UIDebugging
//
//  Created by Xu on 2020/10/28.
//

import UIKit

class UserInfoStackView: UIView {
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var school: UIImageView!
    @IBOutlet weak var level: UIButton!
    @IBOutlet weak var identity: UIButton!
    @IBOutlet weak var introduce: UILabel!
    @IBOutlet weak var follow: UIButton!
    @IBOutlet weak var headImage: UIImageView!
    @IBOutlet weak var profit: UIButton!
    @IBOutlet weak var avgProfit: UIButton!
    @IBOutlet weak var correctProfit: UIButton!
    @IBOutlet weak var commonChoice: UILabel!
    @IBOutlet weak var horizontalStackView: UIStackView!
    @IBOutlet weak var foot: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func followAction(_ sender: UIButton) {
    }
}
