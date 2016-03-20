//
//  SelectionMarker.swift
//  Languini
//
//  Created by Daniel Steinmetz on 20.03.16.
//  Copyright © 2016 Coding Da Vinci. All rights reserved.
//

import UIKit

@IBDesignable class SelectionMarker: UIView {
    

    var triangleColor: UIColor = UIColor.whiteColor()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.blueColor()

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func drawRect(rect: CGRect) {
        let contextRef : CGContextRef = UIGraphicsGetCurrentContext()!
        
        CGContextBeginPath(contextRef)
        CGContextMoveToPoint(contextRef, CGRectGetMinX(rect), CGRectGetMaxY(rect))
        CGContextAddLineToPoint(contextRef, CGRectGetMaxX(rect), CGRectGetMaxY(rect))
        CGContextAddLineToPoint(contextRef, (CGRectGetMaxX(rect)/2.0), CGRectGetMinY(rect))
        CGContextClosePath(contextRef)
        
        CGContextSetFillColorWithColor(contextRef, triangleColor.CGColor)
        CGContextFillPath(contextRef)
    }
    
}
