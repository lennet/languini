//
//  MapViewController.swift
//  Languini
//
//  Created by Daniel Steinmetz on 20.03.16.
//  Copyright © 2016 Coding Da Vinci. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, UIGestureRecognizerDelegate, MKMapViewDelegate  {
    
    @IBOutlet var mapView: MKMapView!
    
    var annotationSet: Bool = false
    var languagesOnSelectedPoint: [Languoid]?
    
    let annotationIdentifier = "annotationView"
    let pinIdentifier = "annotationPin"
    let dictionarySegueIdentifier = "loadDictionaryViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // check network connection
        var reachability: Reachability?
        do {
            reachability = try Reachability(hostname: "www.wikipedia.com")
        } catch {
            print("Unable to create Reachability")
            return
        }
        if reachability?.currentReachabilityStatus == Reachability.NetworkStatus.NotReachable{
            let _ = UIAlertController(title: "No Network Connection", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tappedOnMap(sender: AnyObject) {
        print("tapped")
        let point: CGPoint = sender.locationInView(self.mapView)
        let geoCoder = CLGeocoder()
        let touchCoordinate = mapView.convertPoint(point, toCoordinateFromView: mapView)
        let location = CLLocation(latitude: touchCoordinate.latitude, longitude: touchCoordinate.longitude)
        
        geoCoder.reverseGeocodeLocation(location) {
            (placeMarks: [CLPlacemark]?, error: NSError?) in
            
            guard let placemark = placeMarks?.first else { return }
            
            if let countryCode = placemark.ISOcountryCode{
                self.languagesOnSelectedPoint = LanguoidHelper.getLangouids(forCountryCode: countryCode)
                self.addAnnotationOnLocation(touchCoordinate)
            }
        }
    }
    
    
    
    // MARK: - MKMapViewDelegate
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(annotationIdentifier)
        if annotationView == nil{
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView?.rightCalloutAccessoryView = UIButton(type: UIButtonType.DetailDisclosure)
        }
        annotationView?.enabled = true
        annotationView?.opaque = false
        annotationView?.canShowCallout = true
        
        let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: pinIdentifier)
        pin.canShowCallout = true
        pin.rightCalloutAccessoryView = UIButton(type: UIButtonType.DetailDisclosure)
        
        return pin
    }
    
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let annotation =  view.annotation{
            self.performSegueWithIdentifier(dictionarySegueIdentifier, sender: self)
        }
    }
    
    
    func addAnnotationOnLocation(touchCoordinate: CLLocationCoordinate2D){
        if annotationSet{
            mapView.removeAnnotation(mapView.annotations.last!)
        }
        let languageAnnotation = MKPointAnnotation()
        languageAnnotation.coordinate = touchCoordinate
        languageAnnotation.title = "\(languagesOnSelectedPoint?.count) Sprachen"
        languageAnnotation.subtitle = ""
        annotationSet = true
        mapView.addAnnotation(languageAnnotation)
        
    }
}
