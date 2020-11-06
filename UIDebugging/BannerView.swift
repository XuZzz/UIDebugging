//
//  BannerView.swift
//  UIDebug
//
//  Created by Xu on 2020/10/21.
//

import UIKit


class CompanyProfitRankView: UIView {
    
    private var stock = ""
    private var titleLabel = UILabel(frame: .zero)
    private var moreButton = UIButton(type: .custom)
    private var rankeView = UIView(frame: .zero)
    
    private var leftView = CompanyProfitRankSubview()
    private var rightView = CompanyProfitRankSubview()
    
    private let contents = [("WUKONG", "123"),("Zhang", "234"),("LIU", "099"),("ZHAO", "3912")]
    
    convenience init(stock: String) {
        self.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 135.0))
        self.stock = stock
        buildUI()
    }
    
    private func buildUI() {
        titleLabel
            .builder
            .addhere(at: self)
            .layout { (make) in
                make.top.equalTo(self).offset(5)
                make.left.equalTo(self).offset(10)
            }
            .config { [weak self] (make) in
                make.textAlignment = .left
                make.textColor = .app_main_title
                make.font = UIFont.app_main_big.medium
                make.text = "$\(self!.stock)$收益排行榜"
            }
        
        moreButton
            .builder
            .addhere(at: self)
            .layout { (make) in
                make.right.equalTo(self).offset(-10)
                make.centerY.equalTo(titleLabel)
                make.size.equalTo(CGSize(width: 75, height: 15))
            }
            .config { (make) in
                make.contentHorizontalAlignment = .right
                make.setTitle("查看全部", for: .normal)
                make.setTitleColor(.app_main_subinfo, for: .normal)
                make.titleLabel?.font = .app_main_title
                make.addTarget(self, action: #selector(moreAction(sender:)), for: .touchUpInside)
            }
        
        rankeView
            .builder
            .addhere(at: self)
            .layout { (make) in
                make.top.equalTo(titleLabel.snp.bottom).offset(10)
                make.leading.equalTo(self)
                make.trailing.equalTo(self)
                make.bottom.equalTo(self)
            }
            .config { (make) in
                make.backgroundColor = .white
            }
        leftView = CompanyProfitRankSubview(type: .all,
                                            contents: contents)
        rankeView.addSubview(leftView)
        leftView.snp.makeConstraints { (make) in
            make.top.left.bottom.equalTo(rankeView)
            make.width.equalTo((SCREEN_WIDTH) / 2 )
        }
        
        rightView = CompanyProfitRankSubview(type: .all,
                                            contents: contents)
        rankeView.addSubview(rightView)
        
        rightView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(rankeView)
            make.left.equalTo(leftView.snp.right)
            make.width.equalTo((SCREEN_WIDTH) / 2 )
        }
        
    }
    
    @objc private func moreAction(sender: UIButton) {
        
    }
}

class CompanyProfitRankSubview: UIView {
    
    typealias Content = (name: String, profit: String)
    
    public enum SubType: String {
        case all = "总\n收\n益\n榜"
        case avg = "均\n收\n益\n榜"
    }
    
    private var type: SubType = .all
    private var contents: [Content] = []
    
    private var titleLabel = UIButton(type: .custom)
    private var contentView = UIStackView(frame: .zero)
    
    override func draw(_ rect: CGRect) {
        func getShadowpath()-> CGPath {
            return UIBezierPath(
                        roundedRect: CGRect(x: 0,
                                            y: 0,
                                            width: bounds.width - 25 - 10,
                                            height: bounds.height),
                        cornerRadius: 10)
                        .cgPath
        }
        contentView.layer.cornerRadius = 10
        contentView.layer.borderColor = UIColor(hexString: "FFCCCF").cgColor
        contentView.layer.borderWidth = 1
        contentView.layer.shadowPath = getShadowpath()
        contentView.layer.shadowColor = UIColor(hexString: "FFCCCF").cgColor
        contentView.layer.shadowOpacity = 1.0
        contentView.layer.shadowOffset = CGSize(width: 3, height: 3)
        contentView.layer.shadowRadius = 3
    }
    
    convenience init(type: SubType, contents: [(String, String)]) {
        self.init(frame: CGRect(x: 0, y: 0, width: 167, height: 87))
        self.type = type
        self.contents = contents
        buildUI()
    }
    
    private func buildUI() {

        contentView
            .builder
            .addhere(at: self)
            .layout { (make) in
                make.left.equalTo(self).offset(25)
                make.top.bottom.equalTo(self)
                make.right.equalTo(self).offset(-10)
            }
            .config { [weak self](make) in
                make.axis = .vertical
                make.alignment = .fill
                make.distribution = .equalSpacing
                make.spacing = 8
                
                let top = UIView(frame: .zero)
                make.addArrangedSubview(top)
                top.snp.makeConstraints { (space) in
                    space.height.equalTo(2)
                }
                
                for (index, value) in self!.contents.enumerated() {
                    let label = UILabel(frame: .zero)
                    label.textAlignment = .left
                    label.font = .app_main_title
                    label.textColor = .app_main_content
                    label.text = "\(index + 1)" + value.name + " " + value.profit + "%"
                    make.addArrangedSubview(label)
                    label.snp.makeConstraints { (sub) in
                        sub.left.equalTo(make).offset(20)
                        sub.right.equalTo(make)
                        sub.height.equalTo(15)
                    }
                }
                
                let bottom = UIView(frame: .zero)
                make.addArrangedSubview(bottom)
                bottom.snp.makeConstraints { (space) in
                    space.height.equalTo(2)
                }
                
                make.backgroundColor = .white
            }
        
        titleLabel
            .builder
            .addhere(at: self)
            .layout { (make) in
                make.left.equalTo(self).offset(10)
                make.centerY.equalTo(self)
                make.size.equalTo(CGSize(width: 25, height: 75))
            }
            .config { [weak self] (make) in
                make.backgroundColor = .app_main_white
                make.layer.cornerRadius = 10
                make.layer.borderWidth = 1
                make.layer.borderColor = UIColor(hexString: "FFCCCF").cgColor
                make.setTitle(self!.type.rawValue, for: .normal)
                make.setTitleColor(.app_main_red, for: .normal)
                make.titleLabel?.font = UIFont.app_main_subinfo.medium
                make.titleLabel?.numberOfLines = 4
                titleLabel.layer.masksToBounds = true
            }
    }
}




class HotStockView: UIView {
    private lazy var hotButton: UIButton = {
        let button = UIButton(type: .custom)
        return button
    }()
    private var bottomBorderView = UIView(frame: .zero)
    private var bottomView = UIView(frame: .zero)
    
    private var name: String?
    private var dropRange: String?
    private var hot: String?
    private var contents: [(image: String, content: String)]?
    
    convenience init(name: String, dropRange: String, hot: String, contents: [(String, String)]) {
        self.init(frame: CGRect(x: 0, y: 0, width: 145, height: 82.5))
        self.name = name
        self.dropRange = dropRange
        self.hot = hot
        self.contents = contents
        buildUI()
    }
    override func draw(_ rect: CGRect) {
        var startColor = UIColor.app_main_red
        var endColor = UIColor(hexString: "#EE8120")
        var shadowColor = UIColor.app_main_red
        if let range = dropRange?.toFloat(), range < 0 {
            startColor = UIColor(hexString: "#80E096")
            endColor = UIColor(hexString: "#3EC6D0")
            shadowColor = UIColor(hexString: "#80E096")
        }
        
        hotButton.setBackgroundGradientColor(colors: [startColor, endColor],
                                             startPoint: CGPoint(x: 0, y: 0),
                                             endPoint: CGPoint(x: 1, y: 1),
                                             cornerRadius: 12.5)
        hotButton.layer.shadowColor = shadowColor.cgColor
        hotButton.layer.shadowOffset = .zero
        hotButton.layer.shadowRadius = 5
        hotButton.layer.cornerRadius = 12.5
        
        bottomBorderView.setBackgroundGradientColor(colors: [startColor, endColor],
                                             startPoint: CGPoint(x: 0, y: 0),
                                             endPoint: CGPoint(x: 1, y: 1),
                                             cornerRadius: 5)
    }
    
    
    private func buildUI() {
        bottomBorderView
            .builder
            .addhere(at: self)
            .layout { (make) in
                make.top.equalTo(self).offset(22.5)
                make.left.right.equalTo(self)
                make.size.equalTo(CGSize(width: 145, height: 70))
            }.config { (make) in
                make.layer.cornerRadius = 5
            }
        
        bottomView
            .builder
            .addhere(at: bottomBorderView)
            .layout { (make) in
                make.left.top.equalTo(bottomBorderView).offset(1.5)
                make.right.bottom.equalTo(bottomBorderView).offset(-1.5)
            }.config { (make) in
                make.backgroundColor = .white
                make.layer.cornerRadius = 5
            }
        
        hotButton
            .builder
            .addhere(at: bottomBorderView)
            .layout { (make) in
                make.centerX.equalTo(bottomBorderView)
                make.centerY.equalTo(bottomBorderView.snp.top)
                make.size.equalTo(CGSize(width: 125, height: 25))
            }
            .config { (make) in
                var name = "贵州茅台"
                var dropRange: Double = 2.31
                var tag = " \(dropRange)%"
                if dropRange >= 0 {
                    tag = " +\(dropRange)%"
                }
                if name.count > 4 {
                    name = name.subString(to: 3) + "."
                }
                let range = NSRange(location: name.count,
                                    length: tag.count)
                let attr = NSMutableAttributedString(string: name + tag)

                attr.addAttribute(.font,
                                  value: UIFont.systemFont(ofSize: 12),
                                  range: range)

                make.setAttributedTitle(attr, for: .normal)
                make.setTitleColor(.white, for: .normal)
                make.titleLabel?.font = .app_main_title
            }
    }
}


class UsercenterHeaderview: UIView {
    
    private let showView = UIView(frame: .zero)
    private lazy var backgroundImage: UIImageView = {
        let i = UIImageView(frame: .zero)
        i.backgroundColor = UIColor.cyan.withAlphaComponent(0.75)
        i.contentMode = .scaleAspectFill
        return i
    }()
    private lazy var userinfoView: UserInfoStackView = {
        let v = Bundle.main.loadNibNamed("UserInfoStackView", owner: self, options: [:])?.first as! UserInfoStackView
        v.backgroundColor = .clear
        return v
    }()
   
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        let kRadin = backgroundImage.frame.height
        path.move(to: CGPoint(x: 0, y: kRadin))
        path.addLine(to: CGPoint(x: SCREEN_WIDTH, y: kRadin))
        path.addLine(to: CGPoint(x: SCREEN_WIDTH, y: kRadin - 60))
        path.addLine(to: CGPoint(x: 0, y: kRadin))

        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.strokeColor = UIColor.clear.cgColor
        shape.fillColor = UIColor.white.cgColor
        showView.layer.addSublayer(shape)
        
    }
    
    convenience init(height: CGFloat) {
        self.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: height))
        showView.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: 60)
        buildUI()
    }
    
    func buildUI() {
        backgroundImage
            .builder
            .addhere(at: self)
            .layout { (make) in
                make.left.right.top.equalTo(self)
                make.height.equalTo(190 + 24)
            }
        self.addSubview(showView)
        setupBasicStackview()
    }
    
    func setupBasicStackview() {
        
        self.addSubview(userinfoView)
        userinfoView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.right.equalTo(self).offset(-15)
            // 44 65
            // 64 85
            make.top.equalTo(64 + 21)
            make.bottom.equalTo(self)
        }
    }
}



class ChoicStockTagView: UIView {
    
    public var calculateDone:((CGFloat)-> Void)?
    
    
    private var itemHorizontalMargin: CGFloat {10}
    private var itemVerticalMargin: CGFloat {10}
    
    private let miniumItemWidth: CGFloat = 50
    private let itemHeight: CGFloat = 25
    
    private let width: CGFloat = SCREEN_WIDTH - 20
    private var height: CGFloat = 0
    private var originX: CGFloat = 10
    private var originY: CGFloat = 10
    private var originOffset: CGFloat = 0
    
    
    
    private lazy var stackView: UIStackView = {
        let s = UIStackView(frame: self.bounds)
        s.axis = .horizontal
        s.alignment = .top
        s.distribution = .equalSpacing
        return s
    }()
    
    
    private var choices: [String] = []
    
    convenience init(tags: [String]) {
        self.init(frame: CGRect(x: 10, y: 10, width: SCREEN_WIDTH - 20, height: 55))
        self.choices = tags
        buildUI()
    }
    
    private func buildUI() {
        originX = itemHorizontalMargin
        originY = itemVerticalMargin
        var index: CGFloat = 0.0
        var lastWidth: CGFloat = 0.0
        for value in choices {
            var size = getTextSize(content: value)
            if size.width < miniumItemWidth {
                size.width = miniumItemWidth
            }
            originOffset = lastWidth + itemHorizontalMargin
            if originOffset + size.width >= width {
                originY += itemVerticalMargin + itemHeight
                originOffset = itemVerticalMargin
                lastWidth = size.width + 10
                index = 0.0
            }else {
                index += 1.0
                lastWidth = size.width + 10 + originOffset
            }
            
            let tag = UIButton(type: .custom)
            tag.setTitle("\(value)", for: .normal)
            tag.setTitleColor(.app_main_content, for: .normal)
            tag.setTitleColor(.app_main_red, for: .selected)
            tag.backgroundColor = .app_main_buttonBackground
            tag.layer.cornerRadius = 12.5
            tag.titleLabel?.font = UIFont.app_main_subinfo
        
            tag.frame = CGRect(x: originOffset, y: originY, width: size.width, height: itemHeight)
            self.addSubview(tag)
        }
        
        height = originY + itemHeight + itemHorizontalMargin
        self.calculateDone?(height)
        
        self.frame = CGRect(x: 10, y: 10, width: SCREEN_WIDTH - 20, height: height)
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: 5.0)
        layer.cornerRadius = 5.0
        layer.shadowPath = path.cgPath
        layer.shadowColor = UIColor(hexString: "#C2C2C2").cgColor
        layer.shadowOffset = .zero
        layer.shadowOpacity = 1.0
        
    }
    
    func getTextSize(content: String)-> CGSize {
        let str = NSString(string: content)
        var size = str.size(withAttributes: [.font : UIFont.app_main_subinfo])
        size.width += 22
        return size
    }
}



