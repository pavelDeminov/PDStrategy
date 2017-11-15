//
//  PDValueLabel.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 05/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit

class PDValueLabel: PDLabel {
    
    override func setup() {
        super.setup()
        
        font = UIFont.systemFont(ofSize: 14)
        textColor = UIColor.darkGray
        numberOfLines = 0
    }

}
