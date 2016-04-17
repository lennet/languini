//
//  HighscoreViewController.swift
//  Languini
//
//  Created by Leo Thomas on 20/03/16.
//  Copyright © 2016 Coding Da Vinci. All rights reserved.
//

import UIKit

protocol HighscoreDelgate: class {
    func retryQuiz()
    func finishQuiz()
}

class HighscoreViewController: UIViewController, UITableViewDataSource, UITextFieldDelegate {

    var highscoreEntries: [HighScoreEntry] = []
    var quizType = QuizType.Standard
    var currentScore = 0
    var currentScoreIndex = -1
    var name = ""
    weak var delegate: HighscoreDelgate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        highscoreEntries = HighscoreHelper.getTopScoreEntries(quizType) ?? []
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        for (index, entry) in highscoreEntries.enumerate() {
            if entry.score?.integerValue < currentScore {
                currentScoreIndex = index
                return
            }
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        HighscoreHelper.addScore(currentScore, name: name, type: quizType)
    }
    
    // MARK: - Actions
    
    @IBAction func handleRetryButtonPressed() {
        self.delegate?.retryQuiz()
    }
    
    @IBAction func handleFinishButtonPressed() {
        self.delegate?.finishQuiz()
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return max(highscoreEntries.count+1, 5)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == currentScoreIndex {
            let cell = tableView.dequeueReusableCellWithIdentifier("EditableHighscoreTableViewCell", forIndexPath: indexPath) as! EditableHighscoreTableviewCell
            cell.scoreLabel.text =  "\(currentScore) pkt"
            cell.nameTextField.placeholder = Preferences.sharedInstance.getDefaultUserName()
            cell.nameTextField.delegate = self
            return cell
        } else {
            let currentEntry = highscoreEntries[indexPath.row]
            let cell = tableView.dequeueReusableCellWithIdentifier("StaticHighscoreTableViewCell", forIndexPath: indexPath) as! StaticHighscoreTableViewCell
            cell.nameLabel.text = "\(indexPath.row). \(currentEntry.name ?? " ")"
            cell.scoreLabel.text = "\(currentEntry.score) pkt"
            return cell
        }
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        name = textField.text ?? textField.placeholder ?? ""
    }
}
