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
        let touchLocation = tapRecognizer.locationInView(mapView)
        let coordinate = mapView.convertPoint(touchLocation,toCoordinateFromView: mapView)
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location) { (placemarkArray, error) -> Void in
            guard let placemark = placemarkArray?.first else {
                return
            }
            guard let countryCode = placemark.ISOcountryCode else {
                return
            }
            self.quizLogicViewController?.validateAnswer(countryCode, location: location)
        }
    }

}
