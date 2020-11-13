//
//  ViewController.swift
//  UIDebugging
//
//  Created by Xu on 2020/10/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func LivePersentation(_ sender: UIButton) {
        let vc = LivePresentationController()
        vc.style = .shop
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false, completion: nil)
    }
    @IBAction func liveListAction(_ sender: UIButton) {
        let vc = LiveListController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

