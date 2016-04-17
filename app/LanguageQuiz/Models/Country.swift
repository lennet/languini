//
//  Country.swift
//  Languini
//
//  Created by Leo Thomas on 20/03/16.
//  Copyright © 2016 Coding Da Vinci. All rights reserved.
//

import Foundation
import MapKit

@objc(Country)
class Country: NSManagedObject {

    static let entityName = "Country"

    var location: CLLocation {
        get {
            return CLLocation(latitude: Double(latitude ?? 0), longitude: Double(longitude ?? 0))
        }
    }
}
