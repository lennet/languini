//
//  LanguiniUITests.swift
//  LanguiniUITests
//
//  Created by Leo Thomas on 17/04/16.
//  Copyright © 2016 Coding Da Vinci. All rights reserved.
//

import XCTest

class LanguiniUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launchEnvironment = ["UITest": "1"]
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testTakeTutorialScreenshots() {
        sleep(1)
        XCUIApplication().buttons["Quiz"].tap()
        sleep(1)
        snapshot("tutorialQuiz")
    }
    
}
