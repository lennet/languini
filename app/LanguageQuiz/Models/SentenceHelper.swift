//
//  SentenceHelper.swift
//  Languini
//
//  Created by Leo Thomas on 20/03/16.
//  Copyright © 2016 Coding Da Vinci. All rights reserved.
//

import UIKit

class SentenceHelper: CoreDataHelper {

    /**
     
     - returns: Returns random Sentence if available
     */
    func getRandomSentence() -> Sentence? {
        let sentencesCountPredicate = NSPredicate(format: "sentence.@count != 0")
        let count = countObjects(Languoid.entityName, predicate: sentencesCountPredicate)

        let randomNumber = Int(arc4random()) % count-1
        let offset = randomNumber 
        let fetchRequest = NSFetchRequest(entityName: Languoid.entityName)
        fetchRequest.fetchOffset = offset
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = sentencesCountPredicate

        do {
            let languoid = try context.executeFetchRequest(fetchRequest).first as? Languoid
            guard let sentencesArray = languoid?.sentence?.allObjects else {
                return nil
            }
            let randomIndex = Int(arc4random_uniform(UInt32(sentencesArray.count-1)))
            return sentencesArray[randomIndex] as? Sentence
        } catch {
            print("🚫 Fetching random sentence failed: \(error)")
            return nil
        }
    }
}
