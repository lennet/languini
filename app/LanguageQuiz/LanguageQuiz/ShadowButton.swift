//
//  ShadowButton.swift
//  Languini
//
//  Created by Leo Thomas on 30/06/15.
//  Copyright (c) 2015 Coding Da Vinci. All rights reserved.
//

import UIKit

//@IBDesignable not supported for iOS 7
class ShadowButton: UIButton {


    var color: UIColor = UIColor(red: 0.295, green: 0.695, blue: 0.900, alpha: 0.970)
    
    var radius: CGFloat = 1
    
    var opacity: CGFloat = 0.8
    
    var shadowOffset: CGSize = CGSize(width: 2, height: 2)
    
    var shadowBrightness: CGFloat = 0.5
    
    func setShadow() {
        self.backgroundColor = color
        self.layer.shadowColor = shadowColor()
        self.layer.shadowOpacity = Float(opacity);
        self.layer.shadowRadius = radius
        self.layer.shadowOffset = shadowOffset

    }

    func shadowColor() -> CGColorRef {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        return UIColor(hue: hue, saturation: saturation, brightness: (brightness * shadowBrightness), alpha: alpha).CGColor
    }

    override func awakeFromNib() {
        setShadow()
    }


}
