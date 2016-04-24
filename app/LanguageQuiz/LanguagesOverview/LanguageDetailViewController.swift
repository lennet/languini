//
//  LanguageDetailViewController.swift
//  Languini
//
//  Created by Daniel Steinmetz on 23.04.16.
//  Copyright © 2016 Coding Da Vinci. All rights reserved.
//

import UIKit
import MapKit

class LanguageDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var countryLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var leftButton: UIButton!
    @IBOutlet var rightButton: UIButton!
    
    let detailCellIdentifier = "detailCell"
    let sectionHeaderIdentifier = "sectionHeaer"
    
    weak var selectedLanguoid: Languoid?{
        didSet{
            countries = selectedLanguoid?.country?.allObjects as? [Country]
            sections = selectedLanguoid?.getAttributes()
        }
    }
    var countries: [Country]?
    var selectedCountry: Country?{
        didSet{
            if (selectedCountry  == countries?.first){
                leftButton.enabled = false
                rightButton.enabled = true
            }
            if (selectedCountry  == countries?.last){
                leftButton.enabled = true
                rightButton.enabled = false
            }
        }
    }
    
    var sections: [String]?
    
    
    // MARK: - View Handling
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print(navigationController?.navigationBarHidden)
        if let country = countries?.first{
            selectedCountry = country
            countryLabel.text = country.name
            updateMapView(country)
        }
        if countries?.count == 1{
            leftButton.enabled = false
            rightButton.enabled = false
        }
    }
    
    // MARK: -  Map
    
    @IBAction func leftButtonPressed(sender: AnyObject) {
        guard (selectedCountry != nil) else { return }
        
        var index = countries?.indexOf(selectedCountry!)
        index = index?.predecessor()
        
        if let updatedCountry = countries?[index!]{
            selectedCountry = updatedCountry
            updateMapView(updatedCountry)
        }
        
    }
    
    @IBAction func rightButtonPressed(sender: AnyObject) {
        guard (selectedCountry != nil) else { return }
        
        var index = countries?.indexOf(selectedCountry!)
        index = index?.successor()
        
        if let updatedCountry = countries?[index!]{
            selectedCountry = updatedCountry
            updateMapView(updatedCountry)
        }
    }
    
    private func updateMapView(country: Country){
        let location = CLLocationCoordinate2D(latitude: (country.latitude?.doubleValue)!,longitude: (country.longitude?.doubleValue)!)
        let span = MKCoordinateSpan(latitudeDelta: 10.0 , longitudeDelta: 10.0)
        let region = MKCoordinateRegion(center: location, span: span)
        countryLabel.text = selectedCountry?.name
        mapView.setRegion(region, animated: true)
    }
    
    // MARK: - TableView
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let sections =  sections?.count{
            return sections
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(detailCellIdentifier, forIndexPath: indexPath) as? DetailCell
        if cell == nil{
            cell = DetailCell(style: .Default, reuseIdentifier: detailCellIdentifier)
        }
        cell?.textLabel?.text = "Dummy"
        return cell!
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var cell = tableView.dequeueReusableCellWithIdentifier(sectionHeaderIdentifier) as? SectionHeaderCell
        if cell == nil{
            cell = SectionHeaderCell(style: .Default, reuseIdentifier: sectionHeaderIdentifier)
        }
//        cell?.headerLabel.text = "Dummy Header"
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(20.0)
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(20.0)
    }
}
