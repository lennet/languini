//
//  QuizLogicViewController.swift
//  Languini
//
//  Created by Leo Thomas on 31/10/15.
//  Copyright © 2015 Coding Da Vinci. All rights reserved.
//

import UIKit
import MapKit

@objc
protocol QuizLogicDelegate: class {
    func didPressCancelButton()
    func gameOver(score: Int)
    
    optional func updateAnswers(answerLanguoids: [Languoid])
    optional func showNextSentenceButton(gameOver: Bool)
}

enum QuizType: Int {
    case Standard
    case Geo
}

class QuizLogicViewController: UIViewController {
    
    final let defaultPoints = 50
    final let maxDistance = 6000
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextQuestion()
    }

    // MARK - Public Methods
    
    func nextQuestion() {
        if livesLeft > 0 {
            currentSentence = SentenceHelper.getRandomSentence()
            updateAnswers()
        } else {
            self.delegate?.gameOver(score)
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
    
    func validateAnswer(countryCode: String, location: CLLocation) {
        guard let languoid = currentSentence?.languoid else {
            return
        }
        
        var correct = false
        
        if let countriesArray = languoid.country?.allObjects as? [Country]{
            for country in countriesArray where country.code != nil {
                if country.code! == countryCode {
                    livesLeft += 1
                    score += maxDistance
                    correct = true
                }
            }
        }
        
        if !correct {
            let closestCountry = getClosesCountry(location, languoid: languoid)
            let distance = location.distanceFromLocation(closestCountry.location)
            let newPoints = pointsForAnswer(distance)
            if newPoints > 0 {
                score += newPoints
            } else {
                livesLeft -= 1
            }
            updateView(false, nearby: newPoints > 0, distance: distance, closestCountry: closestCountry.country)
        } else {
            updateView(true, nearby:true, distance: nil, closestCountry: nil)
        }
    }
    
    func reset() {
        livesLeft = 4
        score = 0
        nextQuestion()
    }
    
    // MARK: - Private Methods
    
    private func updateView(correctAnswer: Bool, nearby: Bool, distance: Double?, closestCountry: Country?) {
        if correctAnswer {
            sentenceLabel.text = "Richtige Antwort!"
        } else {
            if nearby {
                sentenceLabel.text = "Fast!\n\n Die nächste Richtige Antwort ist \(closestCountry?.nameDe ?? "") \(distance) km von deiner Eingabe entfernt"
            } else {
                sentenceLabel.text = "Falsche Antwort!\n\n Eine richtige Antwort ist \(closestCountry?.nameDe ?? "") \(distance) km von deiner Eingabe entfernt"
            }
        }
        
        self.delegate?.showNextSentenceButton?(livesLeft<=0)
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
    
    private func getClosesCountry(location: CLLocation, languoid: Languoid) -> (location: CLLocation,country: Country) {
        var location = CLLocation(latitude: 0, longitude: 0)
        var minValue = Double(CGFloat.max)
        var closestCountry: Country!
        for country in languoid.country?.allObjects as? [Country] ?? [Country]() {
            let currentLocation = CLLocation(latitude: Double(country.latitude ?? 0), longitude: Double(country.longitude ?? 0))
            let distance = location.distanceFromLocation(currentLocation)
            if distance < minValue {
                location = currentLocation
                minValue = distance
                closestCountry = country
            }
        }
        return (location, closestCountry)
    }
    
    private func pointsForAnswer(distance: Double) -> Int {
        let distanceInMeter = distance / 1000
        return maxDistance - Int(distanceInMeter)
    }
    
    // MARK: - Actions
    
    @IBAction func handleCancelButtonPressed(sender: AnyObject) {
        delegate?.didPressCancelButton()
    }

}
