//
//  PDConfirmButton.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 11/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit

class PDConfirmButton: PDButton {    
    override func setup() {
        super.setup()
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    }

}
