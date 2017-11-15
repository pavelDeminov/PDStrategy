//
//  PDErrorLabel.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 06/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit

class PDErrorLabel: PDLabel {

    override func setup() {
        super.setup()
        
        font = UIFont.systemFont(ofSize: 12)
        textColor = UIColor.red
        numberOfLines = 0
    }

}
