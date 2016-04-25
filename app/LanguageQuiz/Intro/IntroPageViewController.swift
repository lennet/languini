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
    var currentController: UIViewController?
    
    var headlines : [String] = ["Open Data!","Spiele","Entdecke!","Willkommen!"]
    var descriptions : [String] = ["Wir glauben an kostenlose und freie Informationen für alle! Languini besteht zu 100% aus offenen Daten","erforsche die Welt der Sprachen in zwei Spielmodi. Hier muss meht Text uber 4 Zeilen","8.496 Sprachen. Davon 1.121 mit insgesamt 272.585 Beispielsätzen Eine Zeile fehlt","Mit Languini kannst du in die spannende Welt der Linguistik eintauchen und dein Wissen über die Sprachvielfalt trainieren."]
    var images: [String] = ["logoOpenLock","quiz","group","globe"]
    
    var index : Int = 0
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        pageViewController?.setViewControllers([IntroChildViewController.instantiate()], direction: .Forward, animated: true, completion: nil)
        
        view.backgroundColor = UIColor.lngDarkSkyBlueColor()
        
        let pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        pageControl.currentPageIndicatorTintColor = UIColor.whiteColor()
        pageControl.backgroundColor = UIColor.lngDarkSkyBlueColor()
    }

    // MARK: - UIPageViewControllerDataSource
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 4
    }
    

    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let nextViewController = IntroChildViewController.instantiate()


        index = currentViewController.index

        nextViewController.index = index - 1
    
        if index > 1 {
            nextViewController.headlineLabel.text = headlines[nextViewController.index - 1]
            nextViewController.textField.text = descriptions[nextViewController.index - 1]
            nextViewController.image.image = UIImage(named: images[nextViewController.index - 1])
            
            currentViewController.index = nextViewController.index
            return nextViewController
        } else {
            return nil
        }
    
    }
    
    var currentViewController = IntroChildViewController.instantiate()
    
    
    func pageViewController(pageViewCntroller: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let nextViewController = IntroChildViewController.instantiate()

        
        index = currentViewController.index
        index += 1
        
        nextViewController.index = index
        
        if nextViewController.index <= 3 {
            nextViewController.headlineLabel.text = headlines[nextViewController.index]
            nextViewController.textField.text = descriptions[nextViewController.index]
            nextViewController.image.image = UIImage(named: images[nextViewController.index])
            
            if nextViewController.index == 3 {nextViewController.exitButton.hidden = false}

            currentViewController.index = nextViewController.index
            
            return nextViewController
        } else {
            return nil
        }
        
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
