//
//  ViewController.swift
//  Demo
//
//  Created by DaiLingchi on 2018/5/22.
//  Copyright © 2018年 DiorStone. All rights reserved.
//

import UIKit
import DSTransition

class Test: PresentConfig {
    var transitionAnimation: TransitionAnimation?
    
    var dismissTransitionAnimation: TransitionAnimation?
    
    
}

class ViewController: UIViewController {

    let present = Presenter()
    let viewVC = UIViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func presentAction(_ sender: Any) {
        present.configer { (configer: Test) in
        }
        let vc = ViewController1()
        vc.transitioningDelegate = present
        vc.modalPresentationStyle = .custom
        self.present(vc, animated: true, completion: nil)
    }

}

