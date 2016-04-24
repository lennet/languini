//
//  MenuViewController.swift
//  Languini
//
//  Created by Daniel Steinmetz on 24.04.16.
//  Copyright © 2016 Coding Da Vinci. All rights reserved.
//

import UIKit
import SceneKit

class MenuViewController: UIViewController {

    @IBOutlet var sceneView: SCNView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = EarthScene()
        
        sceneView.backgroundColor = UIColor.clearColor()
        sceneView.autoenablesDefaultLighting = true
        sceneView.scene = scene
        
        scene.doAnimation()
        sceneView.scene = scene

        self.view.addSubview(sceneView)
        NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(MenuViewController.animateSpeechBubble)
            , userInfo: nil, repeats: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func animateSpeechBubble(){
        let speechBubble = SpeechBubble(withColor: CGRect(x: sceneView.frame.width/2 + 50, y: sceneView.frame.height/2 - 50, width: 100, height: 100), color: .whiteColor())
        speechBubble.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001)
        self.view.addSubview(speechBubble)
        
        UIView.animateWithDuration(0.3/1.5, animations: {
            speechBubble.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1)
        }) { (finished) -> Void in
            UIView.animateWithDuration(0.3/2, animations: {
                speechBubble.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9)
                }, completion: { (finished) -> Void in
                    speechBubble.transform = CGAffineTransformIdentity
            })
        }
    }

}
