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
    
    var buttonArray: [QuizButton] {
        get {
            return [firstAnswerButton, secondAnswerButton, thirdAnswerButton, fourthAnswerButton]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func changeAlphaValue(correctLanguoid: Languoid) {
        for button in buttonArray {
            if button.languoid != correctLanguoid {
                button.alpha = 0.7
            }
        }
    }
    
    private func resetAlphaValue() {
        for button in buttonArray {
            button.alpha = 1
        }
    }
    
    // MARK: - Actions
    
    @IBAction func handleAnswerButtonpressed(sender: QuizButton) {
        guard let languoid = sender.languoid else {
            return
        }
        if let correctLangouid = quizLogicViewController?.validateAnswer(languoid) {
            changeAlphaValue(correctLangouid)
        }
    }

    // MARK: - QuizLogicDelegate
    
    func updateAnswers(answerLanguoids: [Languoid]) {
        guard answerLanguoids.count == 4 else {
            return
        }

        resetAlphaValue()
        for (index, button) in buttonArray.enumerate() {
            button.setUpWithLanguoid(answerLanguoids[index])
        }
    }
    
    // MARK: - Orientation
    
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return .Portrait
    }

}
