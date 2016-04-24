//
//  Languoid.swift
//  Languini
//
//  Created by Leo Thomas on 20/03/16.
//  Copyright © 2016 Coding Da Vinci. All rights reserved.
//

import Foundation
import CoreData

@objc(Languoid)
class Languoid: NSManagedObject {

    static let entityName = "Languiod"
    
    let detailUnusedAttributes = ["key", "macroareaGl", "populationNumeric"]

    
    func getCountryString() -> String {
        var resultString = ""
        guard let countriesArray = country?.allObjects as? [Country] else {
            return resultString
        }
        for (index, country) in countriesArray.enumerate() {
            resultString += country.name ?? ""
            if index < countriesArray.count-1 {
                resultString += ", "
            }
        }
        return resultString
    }
    
    func getDetailAttributes() -> [String] {
        var results = [String]()
        let entity = self.entity
        let attributes = entity.attributesByName
        for attribute in attributes{
            let attributeKey = attribute.0
            if let _ = self.valueForKey(attributeKey) {
                if !detailUnusedAttributes.contains(attributeKey){
                    if let value = self.valueForKey(attributeKey) {
                        print(value)
                        results.append(attributeKey)
                    }
                }
            }
        }
        return results
    }
}
