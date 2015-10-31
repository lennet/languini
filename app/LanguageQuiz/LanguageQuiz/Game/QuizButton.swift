//
//  QuizButton.swift
//  Languini
//
//  Created by Leo Thomas on 31/10/15.
//  Copyright © 2015 Coding Da Vinci. All rights reserved.
//

import UIKit

@IBDesignable
class QuizButton: UIButton {
    
    let secondRectangleSize : CGFloat = 48
    let rotation : CGFloat = 45
    let cornerRadius : CGFloat = 6
    let fillColor = UIColor.whiteColor()
    let titleColor = UIColor.blackColor()
    
    override func awakeFromNib() {
        contentHorizontalAlignment = .Left
        contentEdgeInsets = UIEdgeInsets(top: 0, left: secondRectangleSize, bottom: 0, right: 0)
        setTitleColor(titleColor, forState: .Normal)
    }

    override func drawRect(rect: CGRect) {
    
        let context = UIGraphicsGetCurrentContext()
        let distance  = CGPoint(x: 2, y: rect.height/2)
    


        fillColor.setFill()
        
        let rectanglePath = UIBezierPath(roundedRect: CGRectMake(distance.y, 0, rect.width-distance.y, rect.height), cornerRadius: cornerRadius)

        rectanglePath.fill()
        
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, distance.x,  distance.y)
        CGContextRotateCTM(context, -rotation * CGFloat(M_PI) / 180)
        
        let rectangle2Path = UIBezierPath(roundedRect: CGRectMake(0, 0, secondRectangleSize, secondRectangleSize), cornerRadius: cornerRadius)
        rectangle2Path.fill()
        
        CGContextRestoreGState(context)

    }


}
