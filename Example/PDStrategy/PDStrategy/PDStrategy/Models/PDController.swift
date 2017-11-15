//
//  PDController.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 04/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit

class PDController: NSObject {
    var sections: [PDSection]?
    var errorSection: PDSection?
    var validationState = PDValidationState.none
    
    required override init() {
        super.init()
        self.setup()
    }
    
    func setup() {
        
    }
    
    func appendData(data: Any) {
        
    }
    
    func validate() {
        validationState = .valid
        
        guard let sections = sections else {
            return
        }
        
        for section in sections {
            section.validate()
            validationState = section.validationState
            if validationState == .invalid {
                errorSection = section
                break
            }
        }
    }
    
    func invalidate() {
        validationState = PDValidationState.none
        errorSection = nil
    }
    
    func dictionary() -> [AnyHashable: Any] {
        var dict = [AnyHashable: Any]()
        
        guard let sections = sections else {
            return dict
        }
        
        for section: PDSection in sections {
            let sectionDict = section.dictionary()
            for (k, v) in sectionDict { dict.updateValue(v, forKey: k) }
        }
        return dict
    }
    
    func errorIndexPath() -> IndexPath? {
        
        weak var wSelf = self
        guard let  sectionIndex = sections?.index(where: { (section) -> Bool in
            return section == wSelf?.errorSection
        }) else {
            return nil
        }
        
        guard let  rowIndex = errorSection?.items?.index(where: { (item) -> Bool in
            return item.itemHash == wSelf?.errorSection?.errorItem?.itemHash
        }) else {
            return nil
        }
    
        return IndexPath(row: rowIndex, section: sectionIndex)
    }
    
}
