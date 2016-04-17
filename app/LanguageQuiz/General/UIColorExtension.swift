//
//  UIColorExtension.swift
//  Languini
//
//  Created by Leo Thomas on 20/03/16.
//  Copyright © 2016 Coding Da Vinci. All rights reserved.
//

extension UIColor {
    
    class func correctAnswerColor() -> UIColor {
        return UIColor.greenColor()
    }
    
    class func wrongAnswerColor() -> UIColor {
        return UIColor.redColor()
    }
    
    class func lngBlackColor() -> UIColor {
        return UIColor(white: 0.0, alpha: 1.0)
    }
    
    class func lngBrightBlueColor() -> UIColor {
        return UIColor(red: 3.0 / 255.0, green: 122.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
    }
    
    class func lngWindowsBlueColor() -> UIColor {
        return UIColor(red: 55.0 / 255.0, green: 113.0 / 255.0, blue: 200.0 / 255.0, alpha: 1.0)
    }
    
    class func lngDarkSkyBlueColor() -> UIColor {
        return UIColor(red: 52.0 / 255.0, green: 152.0 / 255.0, blue: 219.0 / 255.0, alpha: 1.0)
    }

    
}
