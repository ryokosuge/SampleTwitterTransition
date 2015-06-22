//
//  ViewController.swift
//  SampleTwitterTransition
//
//  Created by nagisa-kosuge on 2015/06/22.
//  Copyright (c) 2015年 RyoKosuge. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupBtn()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

// MARK : - IBAction

extension ViewController {
    
    @IBAction func tapBtn(sender: UIButton) {
        let viewController = ModalViewController.initializeViewController()
        presentViewController(viewController, animated: true, completion: nil)
    }
    
}

// MARK : - private

extension ViewController {
    
    private func setupBtn() {
        btn.layer.borderColor = UIColor.blackColor().CGColor
        btn.layer.borderWidth = 2
        btn.layer.cornerRadius = 5
    }
    
}

