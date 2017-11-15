//
//  PDDateLabel.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 05/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit

class PDDateLabel: PDLabel {
    var dateInFormatter: DateFormatter?
    var dateOutFormatter: DateFormatter?
    var date: Date? {
        get {
            if let text = text {
                return dateInFormatter?.date(from: text)
            } else {
                return nil
            }
        }
        
        set {
            if let date = newValue {
                text = dateOutFormatter?.string(from: date)
            } else {
                text = nil
            }
        }
    }

    override func setup() {
        super.setup()
        
        font = UIFont.systemFont(ofSize: 12)
        textColor = UIColor.lightGray
        numberOfLines = 0
    }
}
