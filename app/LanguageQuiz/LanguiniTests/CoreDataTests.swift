//
//  CoreDataTests.swift
//  Languini
//
//  Created by Leo Thomas on 20/03/16.
//  Copyright © 2016 Coding Da Vinci. All rights reserved.
//

import XCTest

@testable import Languini
class CoreDataTests: XCTestCase {
    
    func testCountEntity() {
        XCTAssertEqual(CoreDataHelper().countObjects(Sentence.entityName, predicate: nil), 34074)
        XCTAssertEqual(CoreDataHelper().countObjects(Languoid.entityName, predicate: nil), 8496)
        XCTAssertEqual(CoreDataHelper().countObjects(Country.entityName, predicate: nil), 11963)
    }
    
    func testRandomSentence() {
        var sentences = [Sentence]()
        var duplicates = 0
        for i in 1...50 {
            let sentence = SentenceHelper().getRandomSentence()
            
            if sentences.contains(sentence!) {
                duplicates += 1
            }
            sentences.append(sentence!)
        }
        XCTAssertLessThan(duplicates, 3)
    }
}
