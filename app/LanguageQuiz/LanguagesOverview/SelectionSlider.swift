//
//  SelectionSlider.swift
//  Languini
//
//  Created by Daniel Steinmetz on 20.03.16.
//  Copyright © 2016 Coding Da Vinci. All rights reserved.
//

import UIKit


class SelectionSlider: UIView {
    
    var selectionMarker = SelectionMarker(frame: CGRectMake(0, 0, 20, 20))
    var selectionMarkerPoint: CGPoint?
    var selectionMarkerOffset:CGFloat = 10
    
    var positionSelection1: CGPoint?
    var positionSelection2: CGPoint?
    
    var animationDuration = 0.3
    

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 1.0)
        CGContextSetStrokeColorWithColor(context, UIColor.clearColor().CGColor)
        CGContextMoveToPoint(context, CGRectGetMinX(self.frame), CGRectGetMinY(self.frame))
        CGContextAddLineToPoint(context, CGRectGetMaxX(self.frame), CGRectGetMaxY(self.frame))
        CGContextStrokePath(context)
        
        addSubview(selectionMarker)
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
