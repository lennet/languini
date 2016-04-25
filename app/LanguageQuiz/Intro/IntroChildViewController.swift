//
//  IntroChildViewController.swift
//  Languini
//
//  Created by Leo Thomas on 17/04/16.
//  Copyright © 2016 Coding Da Vinci. All rights reserved.
//

import UIKit

class IntroChildViewController: UIViewController {
    
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var textField: UITextView!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    var index: Int = 0

    static func instantiate() -> IntroChildViewController {
        let storyboard = UIStoryboard(name: "Intro", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("IntroChildViewControllerIdentifier") as! IntroChildViewController
        vc.view.backgroundColor = UIColor.lngDarkSkyBlueColor()
        return vc
    }

}
