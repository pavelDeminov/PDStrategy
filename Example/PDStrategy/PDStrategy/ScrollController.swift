//
//  ScrollController.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 07/01/2018.
//  Copyright © 2018 Pavel Deminov. All rights reserved.
//

import UIKit

enum ScrollControllerItemType {
    case none;
    case titleValue;
}

class ScrollController: PDController {
    
    override func setup() {
        let section = PDSection.instantiate()
        
        var items = [PDItem]()
        
        var item = PDItem.instantiate()
        item.title = "Title"
        items.append(item)
        
        item = PDItem.instantiate()
        item.title = "Title"
        item.value = "Value"
        item.type = ScrollControllerItemType.titleValue
        items.append(item)
        
        section.items = items
        
        sections = [section]
    }
}
