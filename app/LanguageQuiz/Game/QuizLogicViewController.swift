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
    
    final let defaultPoints = 50
    
    var quizType: QuizType
    weak var delegate: QuizLogicDelegate?
    var currentSentence: Sentence? {
        didSet {
            sentenceLabel.text = currentSentence?.sentence
        }
        
    }
    
    var score = 0 {
        didSet {
            scoreLabel.text = "\(score) pkt"
        }
    }
    
    var livesLeft = 4 {
        didSet {
            livesLabel.text = "\(livesLeft)X"
        }
    }
    
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
        
        if quizType == .Standard {
            updateAnswers()
        } else {
        
        }
    }
    
    func validateAnswer(languoid: Languoid) -> Languoid {
        let correct = languoid == currentSentence?.languoid
        if correct {
            score += defaultPoints
        } else {
            livesLeft -= 1
        }
        
        if livesLeft > 0 {
            NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: "nextQuestion", userInfo: nil, repeats: false)
        } else {
            // TODO Finish Game
        }
        return currentSentence!.languoid!
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
        for index in 0...answerLanguoids.count {
            let remainingCount = answerLanguoids.count - index
            let exchangeIndex = index + Int(arc4random_uniform(UInt32(remainingCount)))
            if exchangeIndex != index {
                swap(&answerLanguoids[index], &answerLanguoids[exchangeIndex])
            }
        }
        
        self.delegate?.updateAnswers?(answerLanguoids)
    }
    

    
    // MARK: - Actions
    
    @IBAction func handleCancelButtonPressed(sender: AnyObject) {
        delegate?.didPressCancelButton()
    }

}
