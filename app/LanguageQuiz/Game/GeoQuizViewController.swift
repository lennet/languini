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

    @IBOutlet weak var nextSentenceButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    override internal var quizType: QuizType {
        get {
            return .Geo
        }
    }
    
    // MARK: - MKMapViewDelegate
    
    @IBAction func handleNextSentenceButtonTapped() {
        quizLogicViewController?.nextQuestion()
        nextSentenceButton.hidden = true
    }
    
    func showNextSentenceButton(gameOver: Bool) {
        if gameOver {
            nextSentenceButton.setTitle("Game Over!", forState: .Normal)
        }
        nextSentenceButton.hidden = false
    }
    
    // MARK: - Actions
    
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
