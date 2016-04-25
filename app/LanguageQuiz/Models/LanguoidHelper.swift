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
    
    static func getLangouids(forCountryCode code: String) -> [Languoid]?{
        let predicate = NSPredicate(format: "code == %@", code)
        let fetchRequest = NSFetchRequest(entityName: Country.entityName)
        fetchRequest.predicate = predicate
        
        let countries: [Country]?
        do{
            countries = try context.executeFetchRequest(fetchRequest) as? [Country]
        } catch{
            print("🚫 Fetching Countries for code \(code) failed: \(error)")
            return nil
        }
        
        if let languoids = countries?.first?.languiod {
            return languoids.allObjects as? [Languoid]
        } else { return nil }
    }
    
}
