//
//  PDSection.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 04/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit

class PDSection: NSObject, PDSectionInfo {
    var title: String?
    var value: String?
    var icon: UIImage?
    var iconUrl: URL?
    var items: [PDItemInfo]?
    var validationState = PDValidationState.none
    var errorItem: PDItem?
    var type: Any?
    
    class func section() -> PDSection {
        let section = PDSection()
        section.setup()
        return section
    }
    
    func setup() {
        
    }
    
    func validate() {
        validationState = .valid
        guard let items = items as? [PDItem] else {
            return
        }
        
        for item in items {
            item.validate()
            validationState = item.validationState
            if validationState == .invalid {
                errorItem = item
                break
            }
        }
    }
    
    func invalidate() {
        validationState = .none
        errorItem = nil
    }
    
    func dictionary() -> [AnyHashable: Any] {
        var dict = [AnyHashable: Any]()
        
        guard let items = items as? [PDItem] else {
            return dict
        }
        
        for item in items {
            if let apiKey = item.apiKey, let value = item.value {
                dict[apiKey] = value
            } else if item.apiRequred == true {
                print("Requred apiKey not found \(item.apiKey as Any) in \(item.title as Any)")
            }
        }
        return dict
    }
}
