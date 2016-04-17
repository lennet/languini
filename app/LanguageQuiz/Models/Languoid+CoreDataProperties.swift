//
//  Languoid+CoreDataProperties.swift
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

extension Languoid {

    @NSManaged var alternateNames: NSObject?
    @NSManaged var classification: NSObject?
    @NSManaged var dialects: NSObject?
    @NSManaged var iso6393: String?
    @NSManaged var key: String?
    @NSManaged var lanugageStatus: String?
    @NSManaged var locationDescription: String?
    @NSManaged var macroareaGl: String?
    @NSManaged var name: String?
    @NSManaged var population: String?
    @NSManaged var populationNumeric: NSNumber?
    @NSManaged var country: NSSet?
    @NSManaged var sentence: NSSet?

}
