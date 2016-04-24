//
//  TutorialViewController.swift
//  Languini
//
//  Created by Leo Thomas on 17/04/16.
//  Copyright © 2016 Coding Da Vinci. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(TutorialViewController.handleTap)))
    }
    
    func handleTap() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
