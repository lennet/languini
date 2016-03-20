//
//  SelectionBarButton.swift
//  Languini
//
//  Created by Daniel Steinmetz on 20.03.16.
//  Copyright © 2016 Coding Da Vinci. All rights reserved.
//

import UIKit

class SelectionBarButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func highlightLabel(){
        self.titleLabel?.font = UIFont.boldSystemFontOfSize(18)
    }
    
    func restoreLabelFont(){
        self.titleLabel?.font = UIFont.systemFontOfSize(15)
    }
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
