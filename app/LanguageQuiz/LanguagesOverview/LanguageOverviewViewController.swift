//
//  LanguageOverviewViewController.swift
//  Languini
//
//  Created by Daniel Steinmetz on 20.03.16.
//  Copyright © 2016 Coding Da Vinci. All rights reserved.
//

import UIKit

enum SelectionPosition: Int{
    case List = 1
    case Map = 2
}

class LanguageOverviewViewController: UIViewController {

    @IBOutlet var selectionView: UIView!
    
    
    var listViewController: UIViewController?
    var mapViewController: UIViewController?
    
    @IBOutlet var selectionSlider: SelectionSlider!
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet var listButton: SelectionBarButton!
    @IBOutlet var mapsButton: SelectionBarButton!
    
    
    
    
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
    
    override func viewDidAppear(animated: Bool) {
        activeViewController = listViewController
        updateActiveVC()
        selectionSlider.positionSelection1 = CGPoint(x: listButton.center.x, y: 0)
        selectionSlider.positionSelection2 = CGPoint(x: mapsButton.center.x, y: 0)
        selectionSlider.selectionMarker.center.x = selectionSlider.positionSelection1!.x - selectionSlider.selectionMarkerOffset
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
    
    
    @IBAction func switchViews(sender: AnyObject) {
        switch sender.tag{
        case 1:
            activeViewController = listViewController
            listButton.highlightLabel()
            mapsButton.restoreLabelFont()
            selectionSlider.switchToPosition(.List)
        case 2:
            activeViewController = mapViewController
            mapsButton.highlightLabel()
            listButton.restoreLabelFont()
            selectionSlider.switchToPosition(.Map)
        default:
            return
        }
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
