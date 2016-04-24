//
//  IntroPageViewController.swift
//  Languini
//
//  Created by Leo Thomas on 17/04/16.
//  Copyright © 2016 Coding Da Vinci. All rights reserved.
//

import UIKit

class IntroPageViewController: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    weak var pageViewController: UIPageViewController?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        pageViewController?.setViewControllers([IntroChildViewController.instantiate()], direction: .Forward, animated: true, completion: nil)
        
        let pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
        pageControl.currentPageIndicatorTintColor = UIColor.blackColor()
        pageControl.backgroundColor = UIColor.whiteColor()
    }

    // MARK: - UIPageViewControllerDataSource
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 1
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 4
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        guard let pageChildViewController = viewController as? IntroChildViewController else {
            return viewController
        }
        
        pageViewController.view.backgroundColor = UIColor.randomColor()
        return pageChildViewController
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        guard let pageChildViewController = viewController as? IntroChildViewController else {
            return viewController
        }
        
        pageViewController.view.backgroundColor = UIColor.randomColor()
        return pageChildViewController
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let pageViewController = segue.destinationViewController as? UIPageViewController {
            self.pageViewController = pageViewController
            self.pageViewController?.dataSource = self
            self.pageViewController?.delegate = self
        }
    }
 

}
