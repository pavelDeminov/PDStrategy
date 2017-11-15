//
//  PDTitleLabel.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 05/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit

class PDTitleLabel: PDLabel {
    
    override func setup() {
        super.setup()
        
        font = UIFont.boldSystemFont(ofSize: 16)
        textColor = UIColor.black
        numberOfLines = 0
    }

}
