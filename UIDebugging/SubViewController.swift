//
//  SubViewController.swift
//  UIDebugging
//
//  Created by Xu on 2020/11/4.
//

import UIKit

class SubViewController: UIViewController {

    @objc func injected() {
        self.viewDidLoad()
    }

    private lazy var tableView: UITableView = {
        let t = UITableView(frame: view.bounds, style: .plain)
        t.showsVerticalScrollIndicator = false
        t.showsHorizontalScrollIndicator = false
        t.separatorStyle = .none
        t.delegate = self
        t.dataSource = self
        return t
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.xz_registerCellNib(HomeSteerPeopleCell.self)
        view.addSubview(tableView)
    }

}

extension SubViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.xz_dequeueReusableCell(HomeSteerPeopleCell.self) {
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
}

