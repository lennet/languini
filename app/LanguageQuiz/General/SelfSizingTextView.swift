//
//  SelfSizingTextView.swift
//  Languini
//
//  Created by Leo Thomas on 25/04/16.
//  Copyright © 2016 Coding Da Vinci. All rights reserved.
//

import UIKit

class SelfSizingTextView: UITextView {

    override func awakeFromNib() {
        super.awakeFromNib()
        for constraint in constraints where constraint.firstAttribute == .Height {
            layoutIfNeeded()
            constraint.constant = contentSize.height
            layoutIfNeeded()
        }
    }
}
