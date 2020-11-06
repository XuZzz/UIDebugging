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
        vc.style = .reward
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
    
}

