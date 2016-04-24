//
//  IntroChildViewController.swift
//  Languini
//
//  Created by Leo Thomas on 17/04/16.
//  Copyright © 2016 Coding Da Vinci. All rights reserved.
//

import UIKit

class IntroChildViewController: UIViewController {
    
    static func instantiate() -> IntroChildViewController {
        let storyboard = UIStoryboard(name: "Intro", bundle: nil)
        return storyboard.instantiateViewControllerWithIdentifier("IntroChildViewControllerIdentifier") as! IntroChildViewController
    }

}
