//
//  QuizBaseViewController.swift
//  Languini
//
//  Created by Leo Thomas on 20/03/16.
//  Copyright © 2016 Coding Da Vinci. All rights reserved.
//

import UIKit

class QuizBaseViewController: UIViewController, QuizLogicDelegate {

    internal var quizType: QuizType {
        get {
            return .Standard
        }
    }
    weak var quizLogicViewController: QuizLogicViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - QuizLogicDelegate

    func didPressCancelButton() {
        dismissViewControllerAnimated(true, completion: nil)
    }

    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let quizLogicViewController = segue.destinationViewController as? QuizLogicViewController {
            quizLogicViewController.quizType = quizType
            quizLogicViewController.delegate = self
            self.quizLogicViewController = quizLogicViewController
        }
    }

}
