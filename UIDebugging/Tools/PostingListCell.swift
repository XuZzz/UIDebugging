//
//  PostingListCell.swift
//  UIDebugging
//
//  Created by Xu on 2020/11/3.
//

import UIKit

/*
 1.扩展区域 头部 尾部
 2.文本区域:
    - 标题 富文本
    - 内容 富文本
    - 图片
 3.用户信息:
    - 头像 昵称    阅读、评论、点赞
 */

class PostingListCellConfig {
    
    struct UIConfig {
        var backgroundColor: UIColor?
        var titleFont: UIFont?
        var titleLines: Int?
        var contentFont: UIFont?
        var contentLines: Int?
        
        mutating func basicConfig() {
            backgroundColor = UIColor.app_main_white
            titleFont = UIFont.app_main_title.medium
            titleLines = 2
            contentFont = UIFont.app_main_content
            contentLines = 3
        }
    }
    
    struct SubviewExtensionConfig {
        var topView: UIView?
        var bottomView: UIView?
    }
    
    var postingType: PostingType = .all
    
}

class PostingListCell: UITableViewCell {
    
    private var bottomView = UIView(frame: .zero)

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func setupBottomview() {
        
        
    }

    
    
}
