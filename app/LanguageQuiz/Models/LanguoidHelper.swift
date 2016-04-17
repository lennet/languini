//
//  LanguoidHelper.swift
//  Languini
//
//  Created by Leo Thomas on 20/03/16.
//  Copyright © 2016 Coding Da Vinci. All rights reserved.
//



class LanguoidHelper: CoreDataHelper {
    
    static func getRandomLangouids(withohtLangouid: Languoid, count: Int) -> [Languoid]? {
        let predicate = NSPredicate(format: "key != %@", withohtLangouid.key ?? "")
        let randomNumber = Int(arc4random()) % (countObjects(Languoid.entityName, predicate: predicate));
        let offset = randomNumber - count
        let fetchRequest = NSFetchRequest(entityName: Languoid.entityName)
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = count
        fetchRequest.fetchOffset = offset
        do {
            return try context.executeFetchRequest(fetchRequest) as? [Languoid]
        } catch {
            print("🚫 Fetching random Languoids failed: \(error)")
            return nil

        }
    }
    
}
