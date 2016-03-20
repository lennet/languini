//
//  QuizViewController.swift
//  Languini
//
//  Created by Leo Thomas on 31/10/15.
//  Copyright © 2015 Coding Da Vinci. All rights reserved.
//

import UIKit

class QuizViewController: QuizBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Orientation
    
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return .Portrait
    }

}
