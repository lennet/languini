//
//  HighscoreHelper.swift
//  Languini
//
//  Created by Leo Thomas on 20/03/16.
//  Copyright © 2016 Coding Da Vinci. All rights reserved.
//

class HighscoreHelper: CoreDataHelper {

    static func addScore(score: Int, name: String, type: QuizType) {
        guard let newEntry = NSEntityDescription.insertNewObjectForEntityForName(HighScoreEntry.entityName, inManagedObjectContext: context) as? HighScoreEntry else {
            return
        }
        newEntry.score = score
        newEntry.name = name
        newEntry.quizType = type.rawValue
        saveContext()
    }

    static func getTopScoreEntries(type: QuizType) -> [HighScoreEntry]? {
        let sortDescriptor = NSSortDescriptor(key: "score", ascending: false)
        let predicate = NSPredicate(format: "quizType == %i", type.rawValue)
        return getObjects(HighScoreEntry.entityName, sortDescripor: sortDescriptor, predicate: predicate, fetchLimit: 5) as? [HighScoreEntry]
    }
    
}
