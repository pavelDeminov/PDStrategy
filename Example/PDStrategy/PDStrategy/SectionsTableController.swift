//
//  SectionsTableController.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 05/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit

class SectionsTableController: PDController {
    
    override func setup() {
        
        var sections = [PDSection]()
        
        for s in 1...5 {
            let section = PDSection.instantiate()
            section.title = "Section" + String(s)
            
            var items = [PDItem]()
            for i in 1...10 {
                let item = PDItem.instantiate()
                item.title = "item" + String (i)
                items.append(item)
            }
            
            section.items = items
            sections.append(section)
            
        }
        
        self.sections = sections
    }
    
}
