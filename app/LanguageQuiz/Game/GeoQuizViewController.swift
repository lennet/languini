//
//  GeoQuizViewController.swift
//  Languini
//
//  Created by Leo Thomas on 20/03/16.
//  Copyright © 2016 Coding Da Vinci. All rights reserved.
//

import UIKit
import MapKit

class GeoQuizViewController: QuizBaseViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    override internal var quizType: QuizType {
        get {
            return .Geo
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - MKMapViewDelegate
    
    @IBAction func handleTapOnMap(tapRecognizer: UITapGestureRecognizer) {
        let location = tapRecognizer.locationInView(mapView)
        let coordinate = mapView.convertPoint(location,toCoordinateFromView: mapView)
        print(coordinate)
    }

}
