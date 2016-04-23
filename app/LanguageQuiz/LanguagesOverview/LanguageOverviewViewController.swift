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


class LanguageOverviewViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet var selectionView: UIView!
    
    
    var listViewController: UIViewController?
    var mapViewController: UIViewController?
    
    @IBOutlet var selectionSlider: SelectionSlider!
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet var listButton: SelectionBarButton!
    @IBOutlet var mapsButton: SelectionBarButton!
    
   var currentView = SelectionPosition.List
    
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
        //setup gesture recognizers
        let swipeRight = UISwipeGestureRecognizer(target: self, action:#selector(LanguageOverviewViewController.switchToList))
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        let swipeLeft = UISwipeGestureRecognizer(target: self, action:#selector(LanguageOverviewViewController.switchToMap))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        
        swipeLeft.delegate = self
        swipeRight.delegate = self
        self.view.addGestureRecognizer(swipeRight)
        self.view.addGestureRecognizer(swipeLeft)
        
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        navigationController?.navigationBar.backgroundColor = selectionSlider.backgroundColor
        
        // remove navigation bars bottom line
        let emptyImage = UIImage()
        self.navigationController?.navigationBar.shadowImage = emptyImage
        self.navigationController?.navigationBar.setBackgroundImage(emptyImage, forBarMetrics: UIBarMetrics.Default)
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        // restore old selection
        if currentView == .List{
            activeViewController = listViewController
        } else {
            activeViewController = mapViewController
        }
        updateActiveVC()
        
        if selectionSlider.positionSelection1 == nil {
            let position1CenterX = listButton.center.x-listButton.frame.width-selectionSlider.selectionMarker.frame.width/4
            let position2CenterX = mapsButton.center.x-mapsButton.frame.width-selectionSlider.selectionMarker.frame.width/4
            selectionSlider.positionSelection1 = CGPoint(x: position1CenterX, y: -50)
            selectionSlider.positionSelection2 = CGPoint(x: position2CenterX, y: -50)
            selectionSlider.selectionMarker.center.x = selectionSlider.positionSelection1!.x - selectionSlider.selectionMarkerOffset
        }
        navigationController?.navigationBar.topItem?.title = "Sprachen"
    }
    
    override func viewWillLayoutSubviews() {
        let positionYValue = CGRectGetMinY(selectionSlider.frame)
        let position1CenterX = listButton.center.x+selectionSlider.selectionMarker.frame.width/2
        let position2CenterX = mapsButton.center.x+selectionSlider.selectionMarker.frame.width/2
        selectionSlider.positionSelection1 = CGPoint(x: position1CenterX, y: -50)
        selectionSlider.positionSelection2 = CGPoint(x: position2CenterX, y: -50)
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
            switchToList()
        case 2:
            switchToMap()
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
    
    
    // MARK: - Gesture
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func  switchToList() {
        activeViewController = listViewController
        listButton.highlightLabel()
        mapsButton.restoreLabelFont()
        selectionSlider.switchToPosition(.List)
        currentView = .List
    }
    
    func switchToMap() {
        activeViewController = mapViewController
        mapsButton.highlightLabel()
        listButton.restoreLabelFont()
        selectionSlider.switchToPosition(.Map)
        currentView = .Map
    }

}
