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

class ScrollController: PDDataSource {
    
    override func setup() {
        let section = PDSection.instantiate()
        
        var items = [PDItem]()
        
        var item = PDItem.instantiate()
        item.title = "Title"
        items.append(item)
        
//        for i in 1...10 {
//            item = PDItem.instantiate()
//            item.title = "Title"
//            item.value = "Value" + String(i)
//            item.type = ScrollControllerItemType.titleValue
//            items.append(item)
//        }
        
        for i in 1...50 {
            item = PDItem.instantiate()
            item.title = "Title" +  String(i)
            items.append(item)
        }
        
        
        section.items = items
        
        sections = [section]
    }
}
