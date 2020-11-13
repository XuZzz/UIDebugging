//
//  LiveListAllLivingView.swift
//  UIDebugging
//
//  Created by 许朕 on 2020/11/11.
//

import UIKit

class LiveListAllLivingView: UIView {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        // item之间的间距
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = .zero
        let collect = UICollectionView(frame: .zero,
                                       collectionViewLayout: layout)
        collect.showsVerticalScrollIndicator = false
        collect.showsHorizontalScrollIndicator = false
        collect.delegate = self
        collect.dataSource = self
        collect.isPagingEnabled = true
        collect.bounces = true
        collect.isScrollEnabled = true
        collect.backgroundColor = .white
        collect.layer.cornerRadius = 10
        collect.register(UINib(nibName: "LiveListAllLivingCell",
                               bundle: nil),
                         forCellWithReuseIdentifier: "LiveListAllLivingCell")
        return collect
    }()

    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 120))
    }
    
    private func buildUI() {
        self.addSubview(collectionView)
    }
}

extension LiveListAllLivingView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LiveListAllLivingCell",
                                                      for: indexPath) as! LiveListAllLivingCell
        return cell
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (SCREEN_WIDTH - 5) / 2, height: 110)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
