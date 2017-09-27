//
//  ValidationRule.swift
//  ExpertService
//
//  Created by Pavel Deminov on 27/09/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit

class ValidationRule: NSObject {    
    var validationBlock: ((_ value: Any?) -> (valid: Bool, error:String?) )?
    
    func isValid(value: Any) -> (valid: Bool, error: String?) {
        guard let block = validationBlock else {
            return (true, nil)
        }
        
        return block(value)
    }
}
