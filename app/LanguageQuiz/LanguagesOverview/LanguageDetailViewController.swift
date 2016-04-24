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
    let sectionHeaderIdentifier = "sectionHeader"
    
    weak var selectedLanguoid: Languoid?{
        didSet{
            countries = selectedLanguoid?.country?.allObjects as? [Country]
            sections = selectedLanguoid?.getDetailAttributes()
        }
    }
    var countries: [Country]?
    weak var selectedCountry: Country?{
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
    
    var sections: [String]?{
        didSet{
            values = [String: String]()
            for section in sections!{
                if let value = selectedLanguoid?.valueForKey(section) as? String{
                    values[section] = value
                }  else if let value = selectedLanguoid?.valueForKey(section) as? [String]{ // value is array
                    print(value)
                    let stringRepresentation = value.joinWithSeparator("\n")
                    values[section] = stringRepresentation
                }
            }
        }
    }
    
    var values = [String:String]()
    
    // MARK: - View Handling
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 50.0
        tableView.rowHeight = UITableViewAutomaticDimension
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
        navigationItem.title = selectedLanguoid?.name
        tableView.reloadData()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.mapView.delegate = nil
        self.mapView.removeFromSuperview()
        self.mapView = nil
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
        
        guard sections != nil else { return cell! }
        
        let section = sections![indexPath.section]
        cell?.detailLabel.text = values[section]
        return cell!
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var cell = tableView.dequeueReusableCellWithIdentifier(sectionHeaderIdentifier) as? SectionHeaderCell
        if cell == nil{
            cell = SectionHeaderCell(style: .Default, reuseIdentifier: sectionHeaderIdentifier)
        }
        if let sectionName = sections?[section]{
            cell?.headerLabel.text = NSLocalizedString("attr_\(sectionName)", comment: "")
        }
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableView.sectionHeaderHeight
    }
}
