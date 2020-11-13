//
//  LiveColumnDetailController.swift
//  UIDebugging
//
//  Created by 许朕 on 2020/11/11.
//

import UIKit

class LiveColumnDetailController: UIViewController {
    
    private lazy var headerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(hexString: "#C1B08E")
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        // item之间的间距
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        let collect = UICollectionView(frame: .zero,
                                       collectionViewLayout: layout)
        collect.showsVerticalScrollIndicator = false
        collect.showsHorizontalScrollIndicator = false
        collect.delegate = self
        collect.dataSource = self
        collect.isPagingEnabled = true
        collect.bounces = true
        collect.isScrollEnabled = true
        collect.backgroundColor = .app_main_buttonBackground
        collect.layer.cornerRadius = 10
        collect.register(UINib(nibName: "LiveListAllLivingCell",
                               bundle: nil),
                         forCellWithReuseIdentifier: "LiveListAllLivingCell")
        return collect
    }()
    
    private var columnnumLab = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        VStackView()
            .builder
            .addhere(at: view)
            .layout { (make) in
                make.edges.equalTo(UIEdgeInsets(top: Nav_Height, left: 0, bottom: 0, right: 0))
            }
            .config { (make) in
                make.backgroundColor = .app_main_buttonBackground
            }
            .base
            .add(
                headerView
            ) { (make) in
                make.snp.makeConstraints { (child) in
                    child.height.equalTo(130)
                }
            }
            .add(Spacer(height: 10))
            .add(
                HStackView()
                    .add(Spacer(width: 10))
                    .add(
                        columnnumLab
                            .builder
                            .config({ (child) in
                                child.textColor = .app_main_title
                                child.font = .app_main_title
                                child.text = "已更新12期"
                            }).base
                    ), layout: { (make) in
                        make.snp.makeConstraints { (child) in
                            child.height.equalTo(15)
                        }
                    }
            )
            .add(Spacer(height: 10))
            .add(collectionView)
        
    }
}

extension LiveColumnDetailController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (SCREEN_WIDTH - 25) / 2, height: 110)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
