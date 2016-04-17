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
    var waitingForResponse = true
    var selectedLocation: CLLocation?
    var geodesicPolyline: MKGeodesicPolyline?
    
    @IBAction func handleNextSentenceButtonTapped() {
        if geodesicPolyline != nil {
            mapView.removeOverlay(geodesicPolyline!)
            geodesicPolyline = nil
            selectedLocation = nil
        }
        
        quizLogicViewController?.nextQuestion()
        nextSentenceButton.hidden = true
        waitingForResponse = true
    }
    
    func showNextSentenceButton(gameOver: Bool, closestCountry: Country?) {
        if gameOver {
            nextSentenceButton.setTitle(NSLocalizedString("GameOverMessage", comment: ""), forState: .Normal)
        }
        if let country = closestCountry {
            showDistanceLineToCountry(country)
        }
        nextSentenceButton.hidden = false
    }
    
    private func showDistanceLineToCountry(country: Country) {
        guard let location = selectedLocation else {
            return
        }
        
        var coordinates = [location.coordinate, country.location.coordinate]
        geodesicPolyline = MKGeodesicPolyline(coordinates: &coordinates, count: 2)
  
        mapView.setVisibleMapRect(geodesicPolyline!.boundingMapRect, edgePadding: UIEdgeInsets(top: CGRectGetMaxX(quizLogicViewController!.view.frame) + CGRectGetMinY(quizLogicViewController!.view.frame) + 10, left: 15, bottom: 15, right: 15), animated: true)
        
        mapView.addOverlay(geodesicPolyline!)
    }
    
    // MARK: MKMapViewDelegate
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        guard let polyline = overlay as? MKPolyline else {
            return MKOverlayRenderer()
        }
        
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.lineWidth = 3.0
        renderer.strokeColor = UIColor.lngWindowsBlueColor()
        
        return renderer
    }
    
    // MARK: - Actions
    
    @IBAction func handleTapOnMap(tapRecognizer: UITapGestureRecognizer) {
        guard waitingForResponse else {
            return
        }
        waitingForResponse = false
        let touchLocation = tapRecognizer.locationInView(mapView)
        let coordinate = mapView.convertPoint(touchLocation,toCoordinateFromView: mapView)
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        selectedLocation  = location
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
