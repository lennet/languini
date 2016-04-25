//
//  DetailCell.swift
//  Languini
//
//  Created by Daniel Steinmetz on 23.04.16.
//  Copyright © 2016 Coding Da Vinci. All rights reserved.
//

import UIKit

class DetailCell: UITableViewCell {

    @IBOutlet var cellTitle: UILabel!
    @IBOutlet var detailLabel: UILabel!
    
    
    override func prepareForReuse() {
        detailLabel.text  = ""
    }

}
