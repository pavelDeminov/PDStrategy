//
//  SimpleCollectionController.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 12/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit

class SimpleCollectionDataSource: PDDataSource {
    
    override func setup() {
        let section = PDSection.instantiate()
        
        var items = [PDItem]()
        
        var item = PDItem.instantiate()
        item.title = "Title"
        item.type = StaticCellsTableType.title
        items.append(item)
        
        item = PDItem.instantiate()
        item.title = "Title"
        item.value = "Value"
        item.type = StaticCellsTableType.titleValue
        items.append(item)
        
        item = PDItem.instantiate()
        item.title = "Title2"
        item.value = "Value2"
        item.type = StaticCellsTableType.titleValue2
        items.append(item)
        
        item = PDItem.instantiate()
        item.title = "Title"
        item.value = "Value"
        item.date = Date()
        item.type = StaticCellsTableType.titleValueDate
        items.append(item)
        
        item = PDItem.instantiate()
        item.title = "Title2"
        item.value = "Value2"
        item.date = Date()
        item.type = StaticCellsTableType.titleValueDate2
        items.append(item)
        
        item = PDItem.instantiate()
        item.title = "Title3"
        item.value = "Value3"
        item.date = Date()
        item.type = StaticCellsTableType.titleValueDate3
        items.append(item)
        
        item = PDItem.instantiate()
        item.title = "Title"
        item.image = #imageLiteral(resourceName: "image1")
        item.type = StaticCellsTableType.titleImage
        items.append(item)
        
        section.items = items
        
        sections = [section]
    }
    
}
