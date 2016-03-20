//
//  QuizLogicViewController.swift
//  Languini
//
//  Created by Leo Thomas on 31/10/15.
//  Copyright © 2015 Coding Da Vinci. All rights reserved.
//

import UIKit

protocol QuizLogicDelegate: class {
    func didPressCancelButton()
}

enum QuizType {
    case Standard
    case Geo
}


class QuizLogicViewController: UIViewController {
    
    var quizType: QuizType
    weak var delegate: QuizLogicDelegate?
    
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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    
    @IBAction func handleCancelButtonPressed(sender: AnyObject) {
        delegate?.didPressCancelButton()
    }

}
