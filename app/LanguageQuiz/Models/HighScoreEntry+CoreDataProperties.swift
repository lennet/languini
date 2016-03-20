//
//  HighScoreEntry+CoreDataProperties.swift
//  Languini
//
//  Created by Leo Thomas on 20/03/16.
//  Copyright © 2016 Coding Da Vinci. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension HighScoreEntry {

    @NSManaged var name: String?
    @NSManaged var quizType: NSNumber?
    @NSManaged var score: NSNumber?

}
