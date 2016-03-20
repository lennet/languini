//
//  QuizLogicViewController.swift
//  Languini
//
//  Created by Leo Thomas on 31/10/15.
//  Copyright © 2015 Coding Da Vinci. All rights reserved.
//

import UIKit

@objc
protocol QuizLogicDelegate: class {
    func didPressCancelButton()
    
    optional func updateAnswers(answerLanguoids: [Languoid])
}

enum QuizType {
    case Standard
    case Geo
}


class QuizLogicViewController: UIViewController {
    
    var quizType: QuizType
    weak var delegate: QuizLogicDelegate?
    var currentSentence: Sentence?
    var score = 0
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var livesLabel: UILabel!
    @IBOutlet weak var sentenceLabel: UILabel!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        self.quizType = .Standard
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.quizType = .Standard
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nextQuestion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func nextQuestion() {
        currentSentence = SentenceHelper.getRandomSentence()
        sentenceLabel.text = currentSentence?.sentence
        
        if quizType == .Standard {
            updateAnswers()
        } else {
        
        }
    }
    
    func validateAnswer(languoid: Languoid) -> Bool {
        let correct = languoid == currentSentence?.languoid
        print(correct)
        return correct
    }
    
    private func updateAnswers() {
        guard let currentLanguoid = currentSentence?.languoid else {
            return
        }
        var answerLanguoids = [currentLanguoid]
        
        guard let wrongAnswerLanguoids = LanguoidHelper.getRandomLangouids(currentLanguoid, count: 3) else {
            return
        }
        answerLanguoids.appendContentsOf(wrongAnswerLanguoids)
        self.delegate?.updateAnswers?(answerLanguoids)
    }
    
    // MARK: - Actions
    
    @IBAction func handleCancelButtonPressed(sender: AnyObject) {
        delegate?.didPressCancelButton()
    }

}
