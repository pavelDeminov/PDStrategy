//
//  PDRule.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 04/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit


typealias ValidationBlock = (_ value: Any) -> Bool

class PDRule: NSObject {
    var validationBlock: ValidationBlock?
    var error = ""
    
    func validate(_ value: Any) -> Bool {
        if let validationBlock = validationBlock {
            return validationBlock(value)
        }
        else {
            return true
        }
    }
}

