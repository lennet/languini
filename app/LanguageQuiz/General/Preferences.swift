//
//  Preferences.swift
//  Languini
//
//  Created by Leo Thomas on 17/04/16.
//  Copyright © 2016 Coding Da Vinci. All rights reserved.
//

import UIKit

@objc class Preferences: NSObject {
    
    private final let  defaultUserNameKey = "defaultUserName"
    private final let tutorialKey = "tutorial"
    private final let isFirstRunKey = "isFirstRun"
    
    static let sharedInstance = Preferences()
    
    override init() {
        super.init()
        if getIsFirstRun() {
            setDefaults()
            setIsFirstRun(false)
        }
    }
    
    func setDefaults() {
        setShouldShowTutorial(.Geo, value: true)
        setShouldShowTutorial(.Standard, value: true)
    }
    
    func setIsFirstRun(value: Bool) {
        NSUserDefaults.standardUserDefaults().setBool(value, forKey: isFirstRunKey)
    }
    
    func getIsFirstRun() -> Bool {
        if NSUserDefaults.standardUserDefaults().objectForKey(isFirstRunKey) == nil {
            return true
        }
        return NSUserDefaults.standardUserDefaults().boolForKey(isFirstRunKey)
    }
    
    func getDefaultUserName() -> String? {
        return NSUserDefaults.standardUserDefaults().stringForKey(defaultUserNameKey)
    }
    
    func setDefaultUserName(name: String) {
        NSUserDefaults.standardUserDefaults().setObject(name, forKey: defaultUserNameKey)
    }
    
    func shouldShowTutorial(quizType: QuizType) -> Bool {
        return NSUserDefaults.standardUserDefaults().boolForKey(tutorialKey+String(quizType.rawValue))
    }
    
    func setShouldShowTutorial(quizType: QuizType, value: Bool) {
        NSUserDefaults.standardUserDefaults().setBool(value, forKey: tutorialKey+String(quizType.rawValue))
    }
}
