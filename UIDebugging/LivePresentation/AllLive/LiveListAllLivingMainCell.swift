//
//  LiveListAllLivingMainCell.swift
//  UIDebugging
//
//  Created by 许朕 on 2020/11/11.
//

import UIKit

class LiveListAllLivingMainCell: UITableViewCell {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        // item之间的间距
        layout.minimumLineSpacing = 5
        layout.sectionInset = .zero
        let collect = UICollectionView(frame: .zero,
                                       collectionViewLayout: layout)
        collect.showsVerticalScrollIndicator = false
        collect.showsHorizontalScrollIndicator = false
        collect.delegate = self
        collect.dataSource = self
        collect.isPagingEnabled = true
        collect.bounces = true
        collect.isScrollEnabled = false
        collect.backgroundColor = .white
        collect.layer.cornerRadius = 10
        collect.register(UINib(nibName: "LiveListAllLivingCell",
                               bundle: nil),
                         forCellWithReuseIdentifier: "LiveListAllLivingCell")
        return collect
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.addSubview(collectionView)
        self.backgroundColor = .app_main_buttonBackground
        collectionView.backgroundColor = .app_main_buttonBackground
        collectionView.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-10)
            make.top.equalTo(contentView).offset(5)
            make.bottom.equalTo(contentView).offset(-5)
        }
    }
    
}

extension LiveListAllLivingMainCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LiveListAllLivingCell",
                                                      for: indexPath) as! LiveListAllLivingCell
        cell.thumImage.backgroundColor = .app_main_green
        return cell
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (SCREEN_WIDTH - 25) / 2, height: 110)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
