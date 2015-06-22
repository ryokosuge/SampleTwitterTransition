//
//  ModalViewController.swift
//  SampleTwitterTransition
//
//  Created by nagisa-kosuge on 2015/06/22.
//  Copyright (c) 2015年 RyoKosuge. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController {
    
    class func initializeViewController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewControllerWithIdentifier("ModalViewController") as! ModalViewController
        let transition = ModalTransition()
        viewController.transitioningDelegate = transition
        viewController.transition = transition
        return viewController
    }

    @IBOutlet weak var btn: UIButton!
    
    private var transition: ModalTransition?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupBtn()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - IBAction

extension ModalViewController {
    
    @IBAction func tapBtn(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}

// MARK: - private

extension ModalViewController {
    
    private func setupBtn() {
        btn.layer.borderColor = UIColor.blackColor().CGColor
        btn.layer.borderWidth = 2
        btn.layer.cornerRadius = 5
    }
    
}
