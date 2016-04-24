//
//  SpeechBubble.swift
//  Languini
//
//  Created by Daniel Steinmetz on 24.04.16.
//  Copyright © 2016 Coding Da Vinci. All rights reserved.
//

import UIKit

class SpeechBubble: UIView {
    
    var color: UIColor = UIColor.greenColor()

    let greetings = ["السلام عليكم", "Grias god", "Hej", "Shalom", "Salut", "Merheba", "नमस्ते", "ښې چارې", "Hello"]

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init coder not been implemented")
    }
    
    required convenience init(withColor frame: CGRect, color:UIColor? = .None) {
        self.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        if let color = color {
            self.color = color
        }
    }
    
    override func drawRect(rect: CGRect) {
        let rounding:CGFloat = rect.width * 0.05
        
        //Draw the main frame
        let bubbleFrame = CGRect(x: 0, y: 0, width: rect.width, height: rect.height * 2 / 3)
        let bubblePath = UIBezierPath(roundedRect: bubbleFrame, byRoundingCorners: UIRectCorner.AllCorners, cornerRadii: CGSize(width: rounding, height: rounding))
        
        color.setStroke()
        color.setFill()
        bubblePath.stroke()
        bubblePath.fill()
        
        let context = UIGraphicsGetCurrentContext()
        
        CGContextBeginPath(context)
        CGContextMoveToPoint(context, CGRectGetMinX(bubbleFrame) + bubbleFrame.width * 1/3, CGRectGetMaxY(bubbleFrame))
        CGContextAddArcToPoint(context, CGRectGetMaxX(rect) * 1/3, CGRectGetMaxY(rect), CGRectGetMaxX(bubbleFrame), CGRectGetMinY(bubbleFrame), rounding)
        
        CGContextAddLineToPoint(context, CGRectGetMinX(bubbleFrame) + bubbleFrame.width * 2/3, CGRectGetMaxY(bubbleFrame))
        CGContextClosePath(context)
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillPath(context);
        
        let label = UILabel.init(frame: CGRectMake(0, self.bounds.height/4, self.bounds.width, 20))
        label.textAlignment = .Center
        let randomIndex = Int(arc4random_uniform(UInt32(greetings.count)))

        label.text = greetings[randomIndex]
        label.textColor = UIColor.blackColor()
        self.addSubview(label)
    }
    

}
