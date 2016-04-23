//
//  SelectionSlider.swift
//  Languini
//
//  Created by Daniel Steinmetz on 20.03.16.
//  Copyright © 2016 Coding Da Vinci. All rights reserved.
//

import UIKit


class SelectionSlider: UIView {
    
    
    var selectionMarker = UIView(frame: CGRectMake(0, 0, 20, 20))
    var selectionMarkerOffset:CGFloat = 10
    
    var currentSelection: SelectionPosition = SelectionPosition.List
    
    var positionSelection1: CGPoint?
    var positionSelection2: CGPoint?
    var selectedMarker: CGPoint?
    
    var animationDuration = 0.3
    var marker: UIBezierPath?
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        let width: CGFloat = 20
        let height: CGFloat = 10

        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, 0.0)
        
        let selectionFrame = selectionMarker.frame
        let rectPath = UIBezierPath(rect: selectionFrame)
        let path = UIBezierPath()
        
        let point1 = CGPoint(x: 0, y: height)
        let point2 = CGPoint(x: width, y: height)
        let point3 = CGPoint(x: width/2, y: height/2)
        
        path.moveToPoint(point1)
        path.addLineToPoint(point2)
        path.addLineToPoint(point3)
        path.closePath()
        
        rectPath.appendPath(path.bezierPathByReversingPath())
        
        UIColor.whiteColor().set()
        rectPath.fill()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let imageView = UIImageView(image: image)
        selectionMarker.addSubview(imageView)
        addSubview(selectionMarker)
        selectionMarker.center.y = CGRectGetMaxY(self.frame)
    }
    
    
    func switchToPosition(position: SelectionPosition){
        
        UIView.animateWithDuration(animationDuration, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            let newPosition: CGPoint?
            if position == SelectionPosition.List{
                newPosition = self.positionSelection1
            } else {
                newPosition = self.positionSelection2
            }
                self.selectionMarker.center.x = newPosition!.x - self.selectionMarkerOffset
            }, completion: nil)
    }
    
    
}
