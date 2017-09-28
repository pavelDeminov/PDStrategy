//
//  ValidationRule.swift
//  ExpertService
//
//  Created by Pavel Deminov on 27/09/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit

open class ValidationRule: NSObject {
    open var validationBlock: ((_ value: Any?) -> (valid: Bool, error:String?) )?
    
    open func isValid(value: Any) -> (valid: Bool, error: String?) {
        guard let block = validationBlock else {
            return (true, nil)
        }
        
        return block(value)
    }
}
