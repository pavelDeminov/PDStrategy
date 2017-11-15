//
//  PDItem.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 04/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit

enum PDValidationState  {
    case none
    case valid
    case invalid
}

class PDItem: NSObject, PDItemInfo {
    var itemHash: String? {
        get {
            return String(hash)
        }
    }
    
    var title: String?
    var value: Any?
    var date: Date?
    var apiKey: String?
    var placeholder: String?
    var type: Any?
    var image: UIImage?
    var imageUrl: URL?
    var apiRequred: Bool?
    
    var validationState = PDValidationState.none
    var errorRule: PDRule?
    var rules: [PDRule]?
    
    class func item() -> PDItem {
        let item = PDItem()
        item.setup()
        return item
    }
    
    func setup() {
        
    }
    
    func validate() {
        invalidate()
        validationState = .valid
        guard let rules = rules else {
            return
        }
        
        for rule: PDRule in rules {
            let valid: Bool = rule.validate(value as Any)
            if !valid {
                errorRule = rule
                validationState = .invalid
                break
            }
        }
    }
    
    func invalidate() {
        validationState = PDValidationState.none
        errorRule = nil
    }
}
