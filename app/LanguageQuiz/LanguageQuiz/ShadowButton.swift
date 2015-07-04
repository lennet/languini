//
//  ShadowButton.swift
//  Languini
//
//  Created by Leo Thomas on 30/06/15.
//  Copyright (c) 2015 Coding Da Vinci. All rights reserved.
//

import UIKit

@IBDesignable
class ShadowButton: UIButton {


    @IBInspectable var color: UIColor = UIColor.blueColor() {
        didSet {
            setShadow()
        }
    }

    @IBInspectable var radius: CGFloat = 1 {
        didSet {
            setShadow()
        }
    }

    @IBInspectable var opacity: CGFloat = 0.8 {
        didSet {
            setShadow()
        }
    }

    @IBInspectable var shadowOffset: CGSize = CGSize(width: 2, height: 2) {
        didSet {
            setShadow()
        }
    }

    @IBInspectable var shadowBrightness: CGFloat = 0.5 {
        didSet {
            setShadow()
        }
    }

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
