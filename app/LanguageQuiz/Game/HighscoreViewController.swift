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
    weak var delegate: HighscoreDelgate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        highscoreEntries = HighscoreHelper.getTopScoreEntries(quizType) ?? []
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
        return highscoreEntries.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let currentEntry = highscoreEntries[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("StaticHighscoreTableViewCell", forIndexPath: indexPath) as! StaticHighscoreTableViewCell
        cell.nameLabel.text = "\(indexPath.row). \(currentEntry.name ?? " ")"
        cell.scoreLabel.text = "\(currentEntry.score) pkt"
        return cell
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
