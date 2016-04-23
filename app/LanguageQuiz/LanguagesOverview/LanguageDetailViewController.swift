//
//  LanguageDetailViewController.swift
//  Languini
//
//  Created by Daniel Steinmetz on 23.04.16.
//  Copyright © 2016 Coding Da Vinci. All rights reserved.
//

import UIKit
import MapKit

class LanguageDetailViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var countryLabel: UIView!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print(navigationController?.navigationBarHidden)
    }
    
    @IBAction func leftButtonPressed(sender: AnyObject) {
        print("leftButtonPressed")
    }
    
    @IBAction func rightButtonPressed(sender: AnyObject) {
        print("rightButtonPressed")
    }
}
