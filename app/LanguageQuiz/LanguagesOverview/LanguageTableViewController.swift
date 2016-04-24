//
//  LanguageTableViewController.swift
//  Languini
//
//  Created by Daniel Steinmetz on 20.03.16.
//  Copyright © 2016 Coding Da Vinci. All rights reserved.
//

import UIKit

class LanguageTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    var languoids: [Languoid]?
    var detailVC: LanguageDetailViewController?
    
    lazy var fetchedResultsController: NSFetchedResultsController = {
        let fetchRequest = NSFetchRequest(entityName: Languoid.entityName)
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataHelper.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.navigationController)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        do {
            try fetchedResultsController.performFetch()
        }catch{
            let error = error as NSError
            print("Error fetching data \(error), \(error.userInfo)")
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        // add navigationbar if presented from mapView selection
        if isBeingPresented(){
            navigationController?.toolbarHidden = false
        } else {
            navigationController?.toolbarHidden = true
        }
    
        if let indexPath = tableView.indexPathForSelectedRow{
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        
        return 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("languageCell", forIndexPath: indexPath)
        configCell(cell, indexPath: indexPath)
        return cell
    }
    
    func configCell(cell: UITableViewCell, indexPath: NSIndexPath){
        if let language = fetchedResultsController.objectAtIndexPath(indexPath) as? Languoid{
            cell.textLabel?.text = language.name
            if let alternateNames = language.alternateNames as? [String] {
                cell.detailTextLabel?.text = alternateNames.joinWithSeparator(", ")
            }
        }
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if detailVC == nil{
            detailVC = storyboard?.instantiateViewControllerWithIdentifier("detailVC") as? LanguageDetailViewController
        }
        
        if let selectedLanguoid = fetchedResultsController.objectAtIndexPath(indexPath) as? Languoid{
            detailVC?.selectedLanguoid = selectedLanguoid
            navigationController?.pushViewController(detailVC!, animated: true)
        }
    }
    

    

}
