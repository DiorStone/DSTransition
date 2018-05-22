//
//  ViewController.swift
//  Demo
//
//  Created by DaiLingchi on 2018/5/22.
//  Copyright © 2018年 DiorStone. All rights reserved.
//

import UIKit
import DSTransition

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
        present.presentViewController(presentingViewController: self, presentedViewController: ViewController1())
    }

}

