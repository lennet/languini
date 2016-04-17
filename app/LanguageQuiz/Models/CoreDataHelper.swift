//
//  CoreDataHelper.swift
//  Languini
//
//  Created by Leo Thomas on 20/03/16.
//  Copyright © 2016 Coding Da Vinci. All rights reserved.
//

class CoreDataHelper {

    static var context: NSManagedObjectContext {
        get {
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            return appDelegate.managedObjectContext
        }
    }
    
    static func countObjects(entityName: String, predicate: NSPredicate?) -> Int {
        let fetchRequest = NSFetchRequest(entityName: entityName)
        
        if predicate != nil {
            fetchRequest.predicate = predicate;
        }

        var error: NSError? = nil
        return context.countForFetchRequest(fetchRequest, error: &error)
    }
    

    
    static func getObjects(entityName: String, sortDescripor: NSSortDescriptor?, predicate: NSPredicate?, fetchLimit: Int?) -> [AnyObject]? {
        let fetchRequest = NSFetchRequest(entityName: entityName)
        fetchRequest.predicate = predicate
        if fetchLimit != nil {
            fetchRequest.fetchLimit = fetchLimit!
        }
        
        if sortDescripor != nil {
            fetchRequest.sortDescriptors = [sortDescripor!]
        }
        
        do {
            let results = try context.executeFetchRequest(fetchRequest)
            return results
        } catch {
            print("🚫 Fetching \(entityName) failed: \(error)")
            return nil
        }
        
    }
    
    static func saveContext() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.saveContext()
    }
}
