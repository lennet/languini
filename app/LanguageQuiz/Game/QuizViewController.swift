//
//  QuizViewController.swift
//  Languini
//
//  Created by Leo Thomas on 31/10/15.
//  Copyright © 2015 Coding Da Vinci. All rights reserved.
//

import UIKit

class QuizViewController: QuizBaseViewController {
    
    @IBOutlet weak var firstAnswerButton: QuizButton!
    @IBOutlet weak var secondAnswerButton: QuizButton!
    @IBOutlet weak var thirdAnswerButton: QuizButton!
    @IBOutlet weak var fourthAnswerButton: QuizButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Actions
    
    @IBAction func handleAnswerButtonpressed(sender: QuizButton) {
        guard let languoid = sender.languoid else {
            return
        }
        quizLogicViewController?.validateAnswer(languoid)
    }

    // MARK: - QuizLogicDelegate
    
    func updateAnswers(answerLanguoids: [Languoid]) {
        guard answerLanguoids.count == 4 else {
            return
        }
        firstAnswerButton.setUpWithLanguoid(answerLanguoids[0])
        secondAnswerButton.setUpWithLanguoid(answerLanguoids[1])
        thirdAnswerButton.setUpWithLanguoid(answerLanguoids[2])
        fourthAnswerButton.setUpWithLanguoid(answerLanguoids[3])
    }
    
    // MARK: - Orientation
    
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return .Portrait
    }

}
