//
//  CoreDataHelper.swift
//  Languini
//
//  Created by Leo Thomas on 20/03/16.
//  Copyright © 2016 Coding Da Vinci. All rights reserved.
//

class CoreDataHelper {

    var context: NSManagedObjectContext {
        get {
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            return appDelegate.managedObjectContext
        }
    }
    
    func countObjects(entityName: String, predicate: NSPredicate?) -> Int {
        let fetchRequest = NSFetchRequest(entityName: entityName)
        
        if predicate != nil {
            fetchRequest.predicate = predicate;
        }

        let error = NSErrorPointer()
        return context.countForFetchRequest(fetchRequest, error: error)
    }
    
}
