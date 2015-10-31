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
    
    let titleFont = UIFont.systemFontOfSize(20)
    let subTitleFont = UIFont.systemFontOfSize(16)
    
    override func awakeFromNib() {
        setUpTitleLabel()
    }

    override func prepareForInterfaceBuilder() {
        setUpTitleLabel()
    }
    
    
    func setUpTitleLabel() {        
        let titleLabel = UILabel()
        titleLabel.text = "Sprache"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = titleFont
        addSubview(titleLabel)
        
        addWidthConstraintForLabel(titleLabel)
        
        let topConstraint = NSLayoutConstraint(item: titleLabel, attribute:.Top, relatedBy: .GreaterThanOrEqual, toItem: self, attribute: .Top, multiplier: 1, constant: 5)
        addConstraint(topConstraint)
        
        let bottomConstraint = NSLayoutConstraint(item: titleLabel, attribute:.Bottom, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0)
        addConstraint(bottomConstraint)
        
        let subTitleLabel = UILabel()
        subTitleLabel.text = "Land"
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.font = subTitleFont
        addSubview(subTitleLabel)
        
        addWidthConstraintForLabel(subTitleLabel)
        
        let subTopConstraint = NSLayoutConstraint(item: subTitleLabel, attribute:.Top, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0)
        addConstraint(subTopConstraint)

        let subBottomConstraint = NSLayoutConstraint(item: self, attribute:.Bottom, relatedBy: .GreaterThanOrEqual, toItem: subTitleLabel, attribute: .Bottom, multiplier: 1, constant: 5)
        addConstraint(subBottomConstraint)
    }
    


    
    func addWidthConstraintForLabel(label : UILabel){
        let leftConstraint = NSLayoutConstraint(item: label, attribute:.Left, relatedBy: .Equal, toItem: self, attribute: .Left, multiplier: 1, constant: secondRectangleSize)
        addConstraint(leftConstraint)
        
        let rightConstraint = NSLayoutConstraint(item: self, attribute:.Right, relatedBy: .Equal, toItem: label, attribute: .Right, multiplier: 1, constant: 20)
        addConstraint(rightConstraint)

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
