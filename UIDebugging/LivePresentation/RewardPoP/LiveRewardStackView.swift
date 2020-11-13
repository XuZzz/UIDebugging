//
//  LiveRewardStackView.swift
//  UIDebugging
//
//  Created by 许朕 on 2020/11/12.
//

import Foundation


class LiveRewardStackView {
    
    public var stackView = VStackView()
    private(set) public var giftViews: [RewardPopView] = []
    private(set) public var gifts: [Int] = []
    private var topSpacer = Spacer(height: 10)
    private var bottomSpacer = Spacer(height: 10)
    
    
    public func giftComing(number: Int) {
        if giftViews.count < 2 {
            let pop = RewardPopView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH - 30, height: 44))
            stackView
                .add(topSpacer)
                .add(pop) { (make) in
                    make.snp.makeConstraints {
                        $0.height.equalTo(44)
                    }
                }
                .add(bottomSpacer)
            
            giftViews.append(pop)
            pop.newGiftComing(user: "Xu", number: number, type: "飞机")
            pop.animationComplete = {[weak self] in
                self?.stackView.removeArrangedSubview(self!.topSpacer)
                self?.stackView.removeArrangedSubview(self!.bottomSpacer)
                self?.stackView.removeArrangedSubview(pop)
                self?.giftViews.removeFirst()
                if let superView = self!.stackView.superview {
                    UIView.animate(withDuration: 0.1) {
                        superView.layoutIfNeeded()
                    } completion: { (done) in
                        self?.readGiftsCache()
                    }
                }
            }
        }else {
            gifts.append(number)
        }
    }
    
    private func readGiftsCache() {
        if gifts.count > 0, let number = gifts.first {
            gifts.removeFirst()
            giftComing(number: number)
        }
    }
    
    
}
