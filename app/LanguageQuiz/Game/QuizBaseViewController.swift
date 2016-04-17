//
//  QuizBaseViewController.swift
//  Languini
//
//  Created by Leo Thomas on 20/03/16.
//  Copyright © 2016 Coding Da Vinci. All rights reserved.
//

import UIKit

class QuizBaseViewController: UIViewController, QuizLogicDelegate, HighscoreDelgate {

    internal var quizType: QuizType {
        get {
            return .Standard
        }
    }
    weak var quizLogicViewController: QuizLogicViewController?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if shouldShowTutorial() {
            performSegueWithIdentifier("tutorialSegueIdentifier", sender: nil)
        }
    }
    
    private func shouldShowTutorial() -> Bool {
        return Preferences.sharedInstance.shouldShowTutorial(quizType)
    }
    
    // MARK: - HighscoreDelegate
 
    func retryQuiz() {
        quizLogicViewController?.reset()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func finishQuiz() {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }

    
    // MARK: - QuizLogicDelegate

    func didPressCancelButton() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func gameOver(score: Int) {
        performSegueWithIdentifier("GameoverOverlaySegueIdentifier", sender: nil)
    }

    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let quizLogicViewController = segue.destinationViewController as? QuizLogicViewController {
            quizLogicViewController.delegate = self
            self.quizLogicViewController = quizLogicViewController
        } else if let highscoreViewController = segue.destinationViewController as?     HighscoreViewController {
            highscoreViewController.delegate = self
        } else if segue.destinationViewController is TutorialViewController {
            Preferences.sharedInstance.setShouldShowTutorial(quizType, value: false)
        }
    }

}
