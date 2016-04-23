//
//  LanguageTableViewController.swift
//  Languini
//
//  Created by Daniel Steinmetz on 20.03.16.
//  Copyright © 2016 Coding Da Vinci. All rights reserved.
//

import UIKit

class LanguageTableViewController: UITableViewController {

    var languoids: [Languoid]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        loadLanguages()
    }
    
    override func viewWillAppear(animated: Bool) {
        // add navigationbar if presented from mapView selection
        if isBeingPresented(){
            navigationController?.toolbarHidden = false
        } else {
            navigationController?.toolbarHidden = true
        }
    }
    
    private func loadLanguages(){
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        languoids = CoreDataHelper.getObjects(Languoid.entityName, sortDescripor: sortDescriptor, predicate: nil, fetchLimit: nil) as? [Languoid]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if languoids != nil {
            return languoids!.count
        } else {
            return 0
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("languageCell", forIndexPath: indexPath)
        let language = languoids![indexPath.row]
        cell.textLabel?.text = language.name
        print(language.alternateNames)
        if let alternateNames = language.alternateNames as? [String] {
            cell.detailTextLabel?.text = alternateNames.joinWithSeparator(", ")
        }
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
