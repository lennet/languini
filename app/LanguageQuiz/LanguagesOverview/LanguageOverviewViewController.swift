//
//  LanguageOverviewViewController.swift
//  Languini
//
//  Created by Daniel Steinmetz on 20.03.16.
//  Copyright © 2016 Coding Da Vinci. All rights reserved.
//

import UIKit

class LanguageOverviewViewController: UIViewController {

    @IBOutlet var selectionView: UIView!
    @IBOutlet var listButton: UIButton!
    @IBOutlet var mapButton: UIButton!
    
    var listViewController: UIViewController?
    var mapViewController: UIViewController?
    
    var selectionIndicator: UIView?
    
    @IBOutlet var contentView: UIView!
    
    @IBAction func switchViews(sender: AnyObject) {
        switch sender.tag{
        case 1:
            activeViewController = listViewController
        case 2:
            activeViewController = mapViewController
        default:
            return
        }
    }
    
    private var activeViewController: UIViewController? {
        didSet{
            removeOldVC(oldValue)
            updateActiveVC()
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let storyboard = UIStoryboard(name: "Overview", bundle: nil)
        mapViewController = storyboard.instantiateViewControllerWithIdentifier("mapsVC")
        listViewController = storyboard.instantiateViewControllerWithIdentifier("listVC")
    }
    
    override func viewWillAppear(animated: Bool) {
        activeViewController = listViewController
        updateActiveVC()
        print(activeViewController)
    }

    // MARK: - Container Management
    
    private func removeOldVC(viewController: UIViewController?){
        guard let viewController = viewController else {
            return
        }
        
        viewController.willMoveToParentViewController(nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParentViewController()
    }
    
    private func updateActiveVC(){
        guard let currentVC = activeViewController else {
            return
        }
        
        addChildViewController(currentVC)
        activeViewController!.view.frame = self.contentView.bounds
        contentView.addSubview(activeViewController!.view)
        currentVC.didMoveToParentViewController(self)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
