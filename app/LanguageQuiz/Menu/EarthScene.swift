//
//  EarthScene.swift
//  Languini
//
//  Created by Daniel Steinmetz on 24.04.16.
//  Copyright © 2016 Coding Da Vinci. All rights reserved.
//

import UIKit
import SceneKit

class EarthScene: SCNScene {

    let camera: SCNNode
    let earth: SCNNode
    
    var earthRotation: CGFloat
    let earthRotationSpeed: CGFloat
    
    override init() {
        camera = SCNNode()
        camera.camera = SCNCamera()
        camera.position = SCNVector3(x: 0, y: 0, z: 15)
        camera.light = SCNLight()
        camera.light?.type = SCNLightTypeAmbient
        
        let surfaceImage = UIImage(named: "earthMaterial")
        
        earth = SCNNode(geometry: SCNSphere(radius: 4))
        earth.position = SCNVector3(0, 0, 0)
        earth.geometry?.firstMaterial?.ambient.contents = surfaceImage
        earth.geometry!.firstMaterial!.diffuse.contents = earth.geometry!.firstMaterial!.ambient.contents
        earthRotationSpeed = CGFloat(M_PI_4)
        earthRotation = 0
        
        super.init()
        
        self.rootNode.addChildNode(camera)
        self.rootNode.addChildNode(earth)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func rotateNodeLeft(node: SCNNode, value: CGFloat, increase:CGFloat) -> CGFloat
    {
        var rotation = value
        
        if value < CGFloat(-M_PI*2) {
            rotation = value + CGFloat(M_PI*2)
            node.rotation = SCNVector4(x: 0.0, y: 1.0, z: 0.0, w: Float(rotation))
        }
        
        return rotation - increase
    }
    
    func doAnimation(){
        earthRotation = rotateNodeLeft(earth, value: earthRotation, increase: earthRotationSpeed)
        
        SCNTransaction.begin()
        SCNTransaction.setAnimationTimingFunction(CAMediaTimingFunction(name:kCAMediaTimingFunctionLinear))
        SCNTransaction.setAnimationDuration(2.0)
        SCNTransaction.setCompletionBlock{
            self.doAnimation()
        }
        
        earth.rotation = SCNVector4(x: 0.0, y: 1.0, z: 0.0, w: Float(earthRotation))
        
        SCNTransaction.commit()
    }
    
}
